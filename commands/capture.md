---
description: Quick note capture without breaking flow
argument-hint: <note>
---

Claude wrapper for `~/.claude/scripts/capture.sh`.

## Steps

1. Take the argument passed to `/capture "note"`.
   - If no argument: ask "What do you want to capture?"

2. Run:

```bash
~/.claude/scripts/capture.sh "note text"
```

3. Display the script output (one line confirmation).
