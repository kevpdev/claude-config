#!/usr/bin/env bash
# style-reminder.sh — UserPromptSubmit hook for Claude Code
# Injects a one-line style reminder on every user prompt.
# Reinforces the response-style rule in ~/.claude/CLAUDE.md
# ("Style de réponse — TDAH, charge cognitive limitée").
#
# stdin: hook JSON payload (ignored — reminder is unconditional).
# stdout: plain text, surfaced to the model as additional context.
set -euo pipefail

# Drain stdin so the hook host doesn't see a broken pipe.
cat >/dev/null

cat <<'EOF'
✍️ STYLE — reco en 1ère phrase ; dernière ligne = question d'action ; pas de récap final ; 1 ancre visuelle / bloc.
EOF
