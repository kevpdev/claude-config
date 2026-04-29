# Master Rules for Claude Code

## Git: No AI Attribution
- No "Generated with Claude Code" in commits/PRs
- No Co-Authored-By: Claude
- No AI links in descriptions
- Follow repo conventions only

## Git: Commit Messages (Conventional Commits)

### Format
```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types (Required)
**feat:** New feature for the user (not internal tool)
**fix:** Bug fix for the user (not dev environment fix)
**docs:** Documentation only (README, comments, JSDoc)
**style:** Formatting, missing semi-colons, white-space (no code change)
**refactor:** Code change that neither fixes bug nor adds feature
**perf:** Code change that improves performance
**test:** Adding/correcting tests (no production code change)
**chore:** Build process, dependencies, tooling, configs (no src/ change)
**ci:** CI/CD configs (GitHub Actions, Travis, Circle, etc.)
**build:** Build system, external dependencies (webpack, npm, rollup)
**revert:** Revert previous commit (include SHA in subject)

### Scope (Optional)
**Component/module affected:** `auth`, `api`, `ui`, `database`, `user-service`
**Omit if change affects multiple scopes**

### Subject Rules
- **Imperative mood:** "add feature" not "added" or "adds"
- **Lowercase:** `feat: add login` not `feat: Add login`
- **No period:** `fix: resolve crash` not `fix: resolve crash.`
- **Max 50 chars:** Be concise, details in body
- **What/Why not How:** Describe impact, not implementation

### Body (Optional, Recommended for Complex Changes)
- **Wrap at 72 chars**
- **Explain what and why, not how**
- **Separate from subject with blank line**
- **Use bullet points for multiple changes**

### Footer (Optional)
**Breaking changes:** `BREAKING CHANGE: <description>`
**Issue references:** `Closes #123`, `Fixes #456`, `Refs #789`

### Examples

**Simple feature:**
```
feat(auth): add password reset flow
```

**Bug fix with details:**
```
fix(api): prevent race condition in user creation

- Add mutex lock on user table
- Validate email uniqueness before insert
- Return 409 Conflict if duplicate detected

Fixes #234
```

**Breaking change:**
```
feat(api): migrate to GraphQL endpoint

Replace REST API with GraphQL for better flexibility.
Clients must update to new schema.

BREAKING CHANGE: REST endpoints /api/v1/* removed
Migration guide: docs/graphql-migration.md

Closes #567
```

**Documentation:**
```
docs: add API authentication examples
```

**Refactor:**
```
refactor(user-service): extract validation logic

Move email/password validation to separate validators.
No behavior change, improves testability.
```

**Performance:**
```
perf(database): add index on user.email

Query time reduced from 2s to 50ms for large datasets.
```

**Chore:**
```
chore: update dependencies to latest versions
```

### When to Use Each Type

| Type | Use When | Example |
|------|----------|---------|
| **feat** | New user-facing feature | Add dark mode toggle |
| **fix** | Bug affecting users | Fix login button crash |
| **docs** | Only documentation | Update README install steps |
| **style** | Code style (no logic) | Fix indentation, add semicolons |
| **refactor** | Restructure code | Extract helper function |
| **perf** | Improve performance | Cache API responses |
| **test** | Add/update tests | Add unit tests for auth |
| **chore** | Tooling, deps, config | Update webpack to v5 |
| **ci** | CI/CD changes | Add GitHub Actions workflow |
| **build** | Build system | Update tsconfig.json |
| **revert** | Undo previous commit | Revert "feat: add feature X" |

### Anti-Patterns (Avoid)

❌ **Vague:** `fix: fix bug`
✅ **Specific:** `fix(auth): prevent null pointer in logout`

❌ **Past tense:** `feat: added login`
✅ **Imperative:** `feat: add login`

❌ **Capitalized:** `Feat: Add Feature`
✅ **Lowercase:** `feat: add feature`

❌ **Too long:** `feat: add a new feature that allows users to login with email and password and also reset their password if they forget it`
✅ **Concise:** `feat(auth): add login and password reset`

❌ **Multiple types:** `feat/fix: add feature and fix bug`
✅ **Separate commits:** Two commits (one feat, one fix)

### Best Practices

1. **Atomic commits:** One logical change per commit
2. **Commit often:** Small, frequent commits > large infrequent
3. **Test before commit:** Ensure code works (lint, test, build)
4. **Meaningful scope:** Use when helpful, omit if unclear
5. **Link issues:** Always reference issue/ticket if exists
6. **Breaking changes:** Always document in footer with BREAKING CHANGE

### Tools

**Commitlint:** Enforce Conventional Commits
```bash
npm install --save-dev @commitlint/cli @commitlint/config-conventional
```

**Commitizen:** Interactive commit message wizard
```bash
npm install --save-dev commitizen cz-conventional-changelog
git cz  # Instead of git commit
```

---

## Communication

### Token Efficiency
**Never:** Copy docs (link instead), list 20 features (top 3 + "Also: X, Y"), paste full code (pseudocode or gist)
**Always:** Clarify vague questions first, hierarchize (80/20), reference > repeat

### Structure
**TL;DR first:** 50-word summary, details follow
**Format:** Bullets > paragraphs, numbered for steps, code blocks, tables for comparisons
**Lengths:** TL;DR 50w, explanation 150-250w, comparison 200-300w, deep dive 350-450w (on request)

### ADHD-Friendly
**Checklists:** Actionable with checkboxes, clear start/end
**Concise:** 1 sentence + example > 3 sentences, Top 3 + "Also..." > 5 points
**Visual:** Headers, whitespace, tables for dense data

### Feynman Method (Complex Concepts)
1. **Analogy:** Everyday concept, no jargon, build intuition
2. **Progressive detail:** Step-by-step, no jumps
3. **Real example:** Production use case, shows value
4. **Pitfalls:** Common confusions, misconceptions, edge cases

**Example - Microservices:**
- Analogy: Restaurant specialized kitchens vs one kitchen
- Detail: Each service independent, communicate via APIs, one down ≠ all down
- Real: Netflix - streaming/billing/recommendations separate
- Pitfall: Not always better (overhead, complexity), monolith fine for small/medium

---

## Session Auto-Load

Au démarrage de chaque conversation, si `.claude/memory-bank/activeContext.md` existe dans le répertoire courant, lis uniquement les sections "Current Focus" et "Next Steps" — silencieusement, sans le mentionner à l'utilisateur.

---

## Agents — When to Delegate Automatically

Spawn the appropriate agent without waiting to be asked:

| Situation | Agent |
|---|---|
| Question sur archi backend, choix technologique, trade-offs | `backend-architect` |
| Question sur archi frontend, composants, SSR/CSR, state management | `frontend-expert` |
| Question sur schéma DB, query, migration, index | `database-expert` |
| Review qualité code (SOLID, naming, perf, lisibilité) | `code-reviewer` |
| Review sécurité (OWASP, auth, secrets, injection) | `security-reviewer` |
| Générer/mettre à jour Javadoc, JSDoc, README, OpenAPI | `doc-writer` |
| Explorer le codebase pour implémenter une feature | `explore-codebase` |
| Chercher la doc d'une lib ou framework | `explore-docs` |
| Recherche web rapide | `websearch` |

**Règles :**
- Après avoir écrit du code, spawn `code-reviewer` puis `security-reviewer` en parallèle
- Après avoir écrit du code documentable (méthodes publiques, API), spawn `doc-writer`
- Ne pas dupliquer le travail : si tu délègues à un agent, ne refais pas la même analyse toi-même

---

## Specialized Rules (Contextual Loading)

**Code Quality & Architecture:** `rules/quality.md` - SOLID, patterns, TypeScript, performance, domain principles
**Testing:** `rules/testing.md` - TDD, ratios, Pierrain, stubs, réglementaire
**Security:** `rules/security.md` - OWASP, auth, JWT, OAuth, passwords, MFA
**Accessibility:** `rules/a11y.md` - WCAG, semantic HTML, ARIA, keyboard, testing
