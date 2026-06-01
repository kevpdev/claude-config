#!/usr/bin/env bash
# guard-no-claude-in-commit.sh — PreToolUse(Bash) hook for Claude Code
# Blocks git commit commands that:
#   1. include "Claude" or co-authorship mentions
#   2. do not follow Conventional Commits EN format
set -euo pipefail

payload=$(cat)

tool=$(printf "%s" "$payload" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_name',''))" 2>/dev/null || echo "")
[ "$tool" != "Bash" ] && exit 0

cmd=$(printf "%s" "$payload" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('command',''))" 2>/dev/null || echo "")

printf "%s" "$cmd" | grep -qE "git commit" || exit 0

# Block staging the personal bypass risk-ack into the tracked team settings.json.
# Claude Code re-injects "skipDangerousModePermissionPrompt": true into
# ~/.claude/settings.json on bypass launch; it belongs in settings.local.json,
# never in the team file. Only acts when the commit targets the ~/.claude repo.
if printf "%s" "$cmd" | grep -qE "(cd[[:space:]]+[^&|;]*\.claude|git[[:space:]]+-C[[:space:]]+[^&|;]*\.claude)"; then
  if git -C "$HOME/.claude" diff --cached -- settings.json 2>/dev/null \
       | grep -qE "^\+.*skipDangerousModePermissionPrompt"; then
    python3 -c "
import json
print(json.dumps({
    'decision': 'block',
    'reason': 'settings.json is staged with skipDangerousModePermissionPrompt (a personal bypass risk-ack). It must never land in the tracked team file. Run: git restore --staged --worktree settings.json  — this key lives in settings.local.json.'
}))
"
    exit 0
  fi
fi

# Block Claude co-authorship mentions
if printf "%s" "$cmd" | grep -qiE "Co-Authored-By: Claude|claude sonnet|claude opus|claude haiku|noreply@anthropic"; then
  python3 -c "
import json
print(json.dumps({
    'decision': 'block',
    'reason': 'Claude mention detected in commit message. Convention: no Claude or Co-Authored-By references in commits. Remove and retry.'
}))
"
  exit 0
fi

# Extract first line of commit message (handles -m "msg" and heredoc patterns)
msg=$(printf "%s" "$cmd" | python3 -c "
import sys, re
cmd = sys.stdin.read()
# Match: -m \"message\" or -m 'message'
m = re.search(r\"-m\s+[\\\"'](.*?)[\\\"|']\", cmd)
if m:
    print(m.group(1).splitlines()[0].strip())
    sys.exit(0)
# Match heredoc: <<'EOF' ... EOF
m = re.search(r\"<<'?EOF'?\s*\n(.*?)\nEOF\", cmd, re.DOTALL)
if m:
    print(m.group(1).strip().splitlines()[0])
    sys.exit(0)
print('')
" 2>/dev/null || echo "")

# Validate Conventional Commits EN format when extractable (fail-open if not)
if [ -n "$msg" ]; then
  if ! printf "%s" "$msg" | grep -qE "^(feat|fix|refactor|docs|test|chore|perf|ci)(\(.+\))?: .+"; then
    python3 -c "
import json
print(json.dumps({
    'decision': 'block',
    'reason': 'Commit message does not follow Conventional Commits EN format. Expected: <type>(<scope>): <subject>  — types: feat, fix, refactor, docs, test, chore, perf, ci. Example: feat(auth): add JWT refresh token support'
}))
"
    exit 0
  fi
fi

exit 0
