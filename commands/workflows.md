---
description: Quick reference for dev workflows (decision tree + cheat sheet)
---

# Development Workflows - Quick Reference

## ⚡ Quick Decision Tree (5 seconds)

```
What's your situation?

├─ GitHub issue bien défini?
│   └─ /run-tasks #123  (EPCT + commit + PR auto)
│
├─ Bug simple, tu connais le code?
│   └─ /session-start + /oneshot  (5-15min)
│
├─ Feature normale (1-4h)?
│   └─ /session-start + /epct  (Explore-Plan-Code-Test)
│
├─ Grosse feature (multi-jours)?
│   └─ /plan-to-stories  (puis plusieurs sessions EPCT)
│
├─ PR avec review comments?
│   └─ /fix-pr-comments  (batch tous les fixes)
│
├─ CI rouge?
│   └─ /watch-ci  (auto-fix max 3 attempts)
│
└─ Reprendre travail après pause?
    └─ /session-start  (restore contexte)
```

---

## 📋 Cheat Sheet

| Situation | Commande | Durée | Output |
|-----------|----------|-------|--------|
| Quick fix | `/oneshot` | 5-15min | Code + tests |
| Feature | `/epct` | 1-4h | Explore→Plan→Code→Test |
| GitHub issue | `/run-tasks #N` | Auto | EPCT + commit + PR |
| Epic/Plan | `/plan-to-stories` | Setup | Génère stories |
| Start session | `/session-start` | 1min | Charge contexte |
| End session | `/session-end` | 1min | Sauvegarde progress |
| Commit | `/commit` | 30s | Clean commit msg |
| Create PR | `/create-pull-request` | 1min | PR URL |
| Fix reviews | `/fix-pr-comments` | Auto | Implémente fixes |
| Watch CI | `/watch-ci` | Auto | Monitor + fix |

---

## 💡 Patterns Communs

### Quick Fix
```bash
/session-start "Fix bug X"
/oneshot "Fix validation login"
/commit
/session-end
```

### Feature Standard
```bash
/session-start "Feature Y"
/epct "Add password reset"
/commit
/create-pull-request
/session-end
```

### GitHub Issue (Full Auto)
```bash
/run-tasks #123
# → Fait tout: EPCT + commit + PR + link issue
```

### Epic Multi-Stories
```bash
# Setup
/plan-to-stories plan.md  # → AUTH-001, AUTH-002, etc.

# Jour 1
/session-start "AUTH-001"
/epct "Login flow"
/commit
/session-end

# Jour 2
/session-start "AUTH-002"
/epct "JWT tokens"
/commit
/create-pull-request
/session-end
```

### Daily Work (avec pauses)
```bash
# Matin
/session-start "Finish login"
/epct "Login validation"
/commit

# Pause déjeuner (save context)
/session-end

# Après-midi (restore context)
/session-start "Continue"
/epct "Rate limiting"
/commit
/create-pull-request
/session-end
```

---

## 🎯 Tips ADHD

### ✓ DO
- `/session-start` CHAQUE fois (même 5min)
- Commit souvent (small > big)
- `/session-end` sauvegarde ton cerveau
- `/oneshot` si confident (rapide = moins friction)

### ✗ AVOID
- Coder sans `/session-start` (perte contexte)
- Gros commits (hard to review)
- Skip tests (dette technique)
- Trop de WIP (finir avant nouveau)

---

## 🔧 Troubleshooting

**"J'ai oublié où j'étais"**
→ `/session-start` (affiche last session + next steps)

**"EPCT trop lent"**
→ `/oneshot` (skip Plan si tu sais quoi faire)

**"Trop de stories, overwhelmed"**
→ Lire `INDEX.md` → ordre suggéré, start par stories sans deps

**"CI fail, pas envie debug"**
→ `/watch-ci` (auto-fix max 3 attempts)

---

## 📦 Init Projects

**Backend Node/TS:**
```bash
/init-node-ts
# → package.json, tsconfig strict, ESLint, Vitest
```

**Frontend (React/Vue/Next/Nuxt/Svelte/Angular):**
```bash
/new-front-app
# → Ask framework + package manager, use official tools
```

---

**Méthodologies:**
- **EPCT**: Explore → Plan → Code → Test (systematic)
- **OneShot**: Explore → Code → Test (fast, skip Plan)
- **Sessions**: /session-start → work → /session-end (context preservation)

**Docs:**
- Détails commandes: `.claude/commands/<command>.md`
- Règles globales: `.claude/CLAUDE.md`
