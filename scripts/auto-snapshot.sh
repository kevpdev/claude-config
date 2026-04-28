#!/usr/bin/env bash
# Triggered on SessionEnd — silently updates activeContext.md if memory-bank exists
# Zero external dependencies (pure bash + sed + awk)

set -u

MEMORY_BANK="$(pwd)/.claude/memory-bank"
ACTIVE_CONTEXT="$MEMORY_BANK/activeContext.md"
MAX_RECENT_ENTRIES=10

[[ -f "$ACTIVE_CONTEXT" ]] || exit 0

TIMESTAMP=$(date '+%Y-%m-%d %H:%M')

# Collect changed files from git if available
CHANGED_FILES=""
if git rev-parse --is-inside-work-tree &>/dev/null; then
  CHANGED_FILES=$(git status --porcelain 2>/dev/null | awk '{print $NF}' | head -10 | paste -sd, -)
fi

# Update or insert "Last update:" line
if grep -q "^Last update:" "$ACTIVE_CONTEXT"; then
  sed -i.bak "s|^Last update:.*|Last update: $TIMESTAMP (auto-snapshot)|" "$ACTIVE_CONTEXT"
else
  sed -i.bak "1i\\
Last update: $TIMESTAMP (auto-snapshot)\\
" "$ACTIVE_CONTEXT"
fi
rm -f "$ACTIVE_CONTEXT.bak"

# Append changed files entry to Recent Changes
if [[ -n "$CHANGED_FILES" ]] && grep -q "^## Recent Changes" "$ACTIVE_CONTEXT"; then
  sed -i.bak "/^## Recent Changes/a\\
[$TIMESTAMP]: Files touched — $CHANGED_FILES
" "$ACTIVE_CONTEXT"
  rm -f "$ACTIVE_CONTEXT.bak"
fi

# Trim Recent Changes to max N entries (pure awk, no Python)
awk -v max="$MAX_RECENT_ENTRIES" '
  function flush_entries(   limit, i) {
    if (entry_count > 0) {
      limit = (entry_count > max) ? max : entry_count
      for (i = 1; i <= limit; i++) print entries[i]
      delete entries
      entry_count = 0
    }
  }
  BEGIN { in_section = 0; entry_count = 0 }
  /^## Recent Changes/ {
    print
    in_section = 1
    next
  }
  /^## / && in_section {
    flush_entries()
    print ""
    in_section = 0
    print
    next
  }
  in_section {
    if ($0 ~ /^[[:space:]]*$/) next
    entries[++entry_count] = $0
    next
  }
  !in_section { print }
  END { flush_entries() }
' "$ACTIVE_CONTEXT" > "$ACTIVE_CONTEXT.tmp" && mv "$ACTIVE_CONTEXT.tmp" "$ACTIVE_CONTEXT"

exit 0
