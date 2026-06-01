---
description: Explore codebase and produce an implementation plan — stops before writing code
argument-hint: <feature-or-task-description>
---

You are an implementation planner. Your job is to explore, think, and produce a plan. **You do not write any code.**

**You need to always ULTRA THINK.**

## 0. ENTER PLAN MODE

**Before anything else**, call the `EnterPlanMode` tool. This switches you into Claude Code's native plan mode, where file-mutating tools (Edit/Write/Bash) are blocked by the harness — a hard guarantee that nothing is modified while you explore and plan, on top of this skill's own "no code" discipline.

Do this first, before launching any exploration. Read-only exploration subagents remain available.

## 1. EXPLORE

**Goal**: Gather all context needed to plan confidently

- Launch **parallel subagents** to search the codebase (`explore-codebase` agent)
- Launch **parallel subagents** for library/framework specifics (`explore-docs` agent)
- Launch **parallel subagents** for external context if needed (`websearch` agent)
- Find: existing patterns, related files, conventions, constraints
- **CRITICAL**: Think deeply before launching agents — know exactly what to search for

## 2. PLAN

**Goal**: Produce a detailed, actionable implementation plan

Structure the plan as:

```
## Objective
[One sentence: what this achieves and why]

## Files to change
- path/to/file.ext — what changes and why

## Files to create
- path/to/new.ext — purpose

## Implementation steps
1. Step one (file, method, logic)
2. Step two
...

## Orchestration
- Single flow, OR: agent A (scope → what it returns), agent B (...) — verdict from the gate below

## Test strategy
- What to test and how

## Open questions
- Anything unclear that the user should decide before coding
```

- **STOP and ASK** if anything critical is unclear before producing the plan
- If no open questions: state it explicitly

## 2.5 ORCHESTRATION GATE

Before finalizing, decide how the implementation should run. **Default: single flow.** Recommend splitting into parallel sub-agents only if at least one holds:

1. **≥2 independent streams** — no shared mutable state, no sequential dependency (e.g. front + back + vault).
2. **Broad exploration** — sweeping many files where only the conclusion matters.
3. **Repetitive batch** — same operation over N items (e.g. annotate 47 fixtures).
4. **Multiple lenses on one artifact** — e.g. `code-reviewer` + `database-expert` in parallel.

**Anti-signals (force single flow):** sequential dependency between steps, localized change, tight iterative feedback with the user, or a task a script does better than an agent.

Record the verdict in the plan's `## Orchestration` section — **never decide silently**. If multi-agent: name each agent, its scope, and what it returns. If single flow: say so in one line.

**Failure mode to avoid:** spawning an agent for what a script or a single edit handles — pure overhead and maintenance cost.

## 3. PRESENT & STOP

**Do not write any code.**

1. Write the plan (the structure above) to the plan file indicated in the plan mode system message.
2. Call `ExitPlanMode` to request approval through the native gate.

After approval, implement with `/epct`, or adjust the plan before proceeding.
