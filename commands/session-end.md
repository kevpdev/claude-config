---
description: End session and update context
---

End your coding session and preserve context for next time.

## What this does

1. Asks what you accomplished
2. Asks what's next
3. Updates `.claude/memory-bank/activeContext.md` with session summary
4. Optionally commits changes
5. Saves your mental state for tomorrow

## Steps

1. Check for `.claude/memory-bank/activeContext.md`
   - If not found: Warn but still collect info

2. Ask user questions:
   - "What did you accomplish this session?"
   - "What's the next step?" (for tomorrow/next session)
   - "Any new challenges or blockers?"

3. Update `.claude/memory-bank/activeContext.md`:
   - Add to "Recent Changes" with timestamp and files
   - Update "Next Steps" with what user said
   - Add new challenges if any
   - Update "Last update" timestamp

4. Ask if user wants to commit changes:
   - "Would you like to commit these changes?"
   - If yes: Offer to run `/commit`

5. Display session summary

## Usage

```bash
# Interactive - will ask questions
/session-end
```

## Example Interaction

```
📝 Ending session...

What did you accomplish this session?
> Implemented refresh token rotation and added error handling

Great! Which files did you modify?
> lib/auth.ts, api/auth/refresh.ts, middleware.ts

What's the next step for your next session?
> Test edge cases with expired tokens and write integration tests

Any new challenges or blockers?
> None, everything working smoothly

✅ Updated .claude/memory-bank/activeContext.md

Session Summary:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Accomplished:
  - Implemented refresh token rotation
  - Added error handling

Files modified:
  - lib/auth.ts
  - api/auth/refresh.ts
  - middleware.ts

Next session:
  - Test edge cases with expired tokens
  - Write integration tests

Challenges: None
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Would you like to commit these changes? (y/n)
> y

Running /commit...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎉 Session ended! Great work today.

Context preserved in .claude/memory-bank/activeContext.md
Next time you run /session-start, you'll pick up right where you left off.
```

## Updated activeContext.md example

```markdown
# Active Context

Last update: 2025-12-14 17:45

## Current Focus
Authentication system - refresh token rotation complete

## Recent Changes
[2025-12-14 17:45]: **Refresh token rotation**: Implemented token rotation with error handling (lib/auth.ts, api/auth/refresh.ts, middleware.ts)
[2025-12-14 10:30]: **Protected routes**: Added middleware for route protection (middleware.ts)
[2025-12-13 16:00]: **JWT setup**: Initial JWT sign/verify (lib/auth.ts)

## Next Steps
1. [ ] Test edge cases with expired tokens
2. [ ] Write integration tests for auth flow
3. [ ] Add rate limiting to auth endpoints

## Challenges
(None currently)

## Decisions Made
- Using httpOnly cookies for token storage (XSS protection)
- Refresh token rotation on every use (security best practice)
- 15min access token, 7 days refresh token
```

## Benefits

- **No context loss**: Next session starts where you left off
- **Visible progress**: See what you accomplished
- **Clear next steps**: Know exactly what to do next time
- **Decision history**: Remember why you chose certain approaches
- **ADHD-friendly**: External memory, clear transitions

## Notes

- Run this at the end of every coding session
- Even if you didn't finish everything, record progress
- Small wins matter - capture them!
- The act of summarizing helps consolidate learning
