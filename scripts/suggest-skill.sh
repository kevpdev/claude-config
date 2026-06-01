#!/usr/bin/env bash
# suggest-skill.sh — UserPromptSubmit hook for Claude Code
# Reads the user prompt from stdin (JSON payload) and routes to an agent or skill
# based on rules defined in core/config/agent-routing.json.
#
# Behavior:
#   - ALL matching rules are collected (no first-match-wins) → multi-skill menu.
#   - A standing orchestration directive is injected on EVERY prompt, match or not.
#   - target.type=agent  → message asks Claude to delegate via the Task tool.
#   - target.type=skill  → message asks Claude to load `/skill <name>`.
#   - force=true         → impératif ("[requis]").
#   - force=false        → suggestion.
#   - No match           → directive only (Claude judges relevance semantically).
#
# Falls back to legacy hardcoded regex if agent-routing.json is missing.
# Requires: jq, python3.
set -euo pipefail

CORE_DIR="${AI_CORE_DIR:-$HOME/.claude}"
ROUTING="$CORE_DIR/config/agent-routing.json"
ROUTING_EXAMPLE="$CORE_DIR/config/agent-routing.json.example"

# ── Read prompt from stdin ────────────────────────────────────────────────────

prompt=$(python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    print(d.get('prompt', ''))
except Exception:
    print('')
" 2>/dev/null || printf "")

if [ -z "$prompt" ]; then
  exit 0
fi

lower=$(printf "%s" "$prompt" | tr '[:upper:]' '[:lower:]')

# ── Output helper ─────────────────────────────────────────────────────────────

emit() {
  # $1 = additionalContext message
  python3 -c "
import json, sys
print(json.dumps({
    'hookSpecificOutput': {
        'hookEventName': 'UserPromptSubmit',
        'additionalContext': sys.argv[1]
    }
}))
" "$1"
}

# Standing directive injected on every prompt — makes multi-skill evaluation a
# per-turn discipline (delivered by the hook so it never fades in long contexts).
ORCHESTRATION_DIRECTIVE="🧭 Orchestration multi-skill — à chaque requête, évalue AVANT de répondre quelles expertises sont nécessaires (une ou plusieurs en parallèle). Défaut : aucune ou une ; n'escalade en multi que si la question enjambe réellement plusieurs domaines. Charge un skill via \`/skill <nom>\`, délègue le travail indépendant à un sous-agent (Task tool). Les candidats ci-dessous sont déterministes (regex) — à toi de juger la composition finale, y compris des skills non listés."

format_line() {
  # $1=type (agent|skill) $2=name $3=force(true|false) $4=reason → one menu line
  local type="$1" name="$2" force="$3" reason="$4"
  local tag how
  if [ "$force" = "true" ]; then tag="🔧 [requis]"; else tag="💡"; fi
  if [ "$type" = "agent" ]; then
    how="sous-agent \`$name\` (Task tool)"
  else
    how="skill \`$name\` (\`/skill $name\`)"
  fi
  printf "   %s %s — %s" "$tag" "$how" "$reason"
}

# ── Path 1: rules-based routing ───────────────────────────────────────────────

if [ -f "$ROUTING" ] && command -v jq >/dev/null 2>&1; then
  if ! jq empty "$ROUTING" 2>/dev/null; then
    emit "⚠️ agent-routing.json invalide (JSON malformé) — routing désactivé. Corrigez le fichier : $ROUTING"
    exit 0
  fi
  # Collect ALL matching rules (order preserved) → multi-skill menu.
  count=$(jq '.rules | length' "$ROUTING" 2>/dev/null || printf "0")
  menu=""
  i=0
  while [ "$i" -lt "$count" ]; do
    rule=$(jq -c ".rules[$i]" "$ROUTING")
    regex=$(printf "%s" "$rule" | jq -r '.match.regex // empty')
    if [ -n "$regex" ] && printf "%s" "$lower" | grep -qE "$regex"; then
      type=$(printf "%s" "$rule" | jq -r '.target.type')
      name=$(printf "%s" "$rule" | jq -r '.target.name')
      force=$(printf "%s" "$rule" | jq -r '.force // false')
      reason=$(printf "%s" "$rule" | jq -r '.reason')
      line=$(format_line "$type" "$name" "$force" "$reason")
      if [ -z "$menu" ]; then menu="$line"; else menu="$menu
$line"; fi
    fi
    i=$((i + 1))
  done

  if [ -n "$menu" ]; then
    emit "$ORCHESTRATION_DIRECTIVE

Candidats détectés pour ce prompt :
$menu"
  else
    emit "$ORCHESTRATION_DIRECTIVE

Aucun candidat déterministe sur ce prompt — juge toi-même si un skill s'applique sémantiquement."
  fi
  exit 0
fi

# ── Path 2: legacy fallback (no jq, or routing file missing) ──────────────────

emit "⚠️ agent-routing.json absent ou jq manquant — routing en mode fallback legacy (suggestions uniquement, pas de délégation forcée)."

if printf "%s" "$lower" | grep -qE "review|qualit|lisibilit|solid|mainten|refactor|propre|clean code"; then
  skill="code-reviewer"
elif printf "%s" "$lower" | grep -qE "s[eé]curit|auth|secret|inject|owasp|vuln|token|jwt|permiss|xss|csrf"; then
  skill="security-reviewer"
elif printf "%s" "$lower" | grep -qE "architect|api|rest|graphql|microserv|monolith|backend|design pattern|ddd|cqrs|hexagonal"; then
  skill="backend-architect"
elif printf "%s" "$lower" | grep -qE "frontend|react|vue|angular|next|nuxt|ssr|csr|a11y|accessib|composant|component|web vital"; then
  skill="frontend-expert"
elif printf "%s" "$lower" | grep -qE "database|sql|nosql|schema|index|migration|query|postgres|mongo|redis|explain|lent|slow"; then
  skill="database-expert"
elif printf "%s" "$lower" | grep -qE "documente|javadoc|jsdoc|readme|openapi|swagger|commente|doc technique|mise.?à.?jour.*doc"; then
  skill="doc-writer"
else
  exit 0
fi

emit "💡 Skill disponible : \`$skill\` — charge-le avec \`/skill $skill\` pour une expertise spécialisée sur cette tâche."
