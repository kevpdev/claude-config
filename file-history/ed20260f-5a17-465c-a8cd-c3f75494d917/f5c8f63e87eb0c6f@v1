# Claude Code Configuration

Configuration personnalisée pour [Claude Code](https://claude.com/claude-code) - CLI officiel d'Anthropic.

## 📋 Contenu

- **Slash Commands** : Commandes rapides pour workflows courants
- **Global Rules** : Règles et best practices (CLAUDE.md)
- **Templates** : Templates pour projets et documents

## 🚀 Installation

### Cloner la Config

```bash
# Backup config existante (si nécessaire)
mv ~/.claude ~/.claude.backup

# Cloner ce repo
git clone https://github.com/kevpdev/claude-config.git ~/.claude

# Recharger Claude Code
# (redémarrer votre session ou relancer Claude)
```

### Sync Config

```bash
cd ~/.claude
git pull
```

## 📂 Structure

```
.claude/
├── commands/              # Slash commands
│   ├── init-node-ts.md   # Init backend Node/TS
│   ├── new-front-app.md  # Init frontend (React/Vue/Next/Nuxt/etc.)
│   ├── plan-to-stories.md
│   ├── epct.md
│   └── ...
├── CLAUDE.md             # Règles globales (best practices)
├── .gitignore            # Ignore plans/stories temporaires
└── README.md             # Ce fichier
```

## 🛠️ Commandes Disponibles

### Project Initialization

#### `/init-node-ts`
Initialize backend Node.js + TypeScript project.

**Features:**
- TypeScript strict mode
- Package manager choice (pnpm/npm/yarn)
- ESLint + Prettier (optional)
- Vitest pour tests
- Scripts: dev, build, start, test, lint, format

**Usage:**
```bash
/init-node-ts

# Demande interactivement:
? Package manager: pnpm
? Project name: my-backend
? Add ESLint + Prettier? Yes

# Crée:
# - package.json, tsconfig.json
# - src/index.ts, tests/index.test.ts
# - .gitignore, .eslintrc.json, .prettierrc
```

#### `/new-front-app`
Initialize frontend project avec framework de choix.

**Frameworks supportés:**
- React (Vite + React 18 + TS)
- Vue (Vue 3 + Router + Pinia + Vitest)
- Next.js (SSR/SSG + App Router)
- Nuxt (SSR/SSG + Auto-imports)
- Svelte (Vite + Svelte 4 + TS)
- Angular (Angular 17+ + Router)

**Usage:**
```bash
/new-front-app

# Demande interactivement:
? Package manager: pnpm
? Framework: React
? Project name: my-frontend
? Add React Router? Yes

# Utilise les outils officiels:
# - create-vite (React/Vue/Svelte)
# - create-next-app (Next.js)
# - nuxi (Nuxt)
# - @angular/cli (Angular)
```

### Workflow Commands

#### `/plan-to-stories`
Split plan/brief en stories focalisées.

**Features:**
- Smart project detection (skip SETUP si déjà initialisé)
- Génère stories BMAD (self-contained)
- Dependency graph automatique
- Suggestion ordre implémentation

**Usage:**
```bash
/plan-to-stories plan.md

# Crée:
# .claude/memory-bank/stories/
# ├── INDEX.md              # Overview + dépendances
# ├── AUTH-001-login.md
# ├── AUTH-002-jwt.md
# └── USER-001-profile.md
```

#### `/epct`
Explore-Plan-Code-Test methodology.

#### `/oneshot`
Ultra-fast feature implementation.

#### `/commit`
Quick commit and push avec messages clean.

#### `/create-pull-request`
Create PR avec auto-generated title et description.

## 🎨 CLAUDE.md - Global Rules

Règles appliquées à **tous les projets** :

### Architecture
- SOLID principles
- Clean/Hexagonal architecture
- DDD pour domaines complexes

### TypeScript
- `strict: true` toujours
- Pas de `any` (utiliser `unknown`)
- Types explicites sur fonctions publiques

### Testing
- TDD pour logique complexe
- 80% coverage critical paths
- AAA pattern (Arrange-Act-Assert)

### Security
- OWASP Top 10
- Validation input (whitelist)
- JWT: 15min access, httpOnly cookies
- bcrypt 12+ rounds

### Accessibility
- Semantic HTML
- WCAG AA (4.5:1 contrast)
- Keyboard navigation

### Communication
- TL;DR first (50 words)
- Token efficiency (link > copy)
- ADHD-friendly (checklists, concise)

## 🔧 Customization

### Ajouter Commande

```bash
cd ~/.claude/commands
touch my-command.md

# Format:
---
description: Brief description
---

Command instructions here...
```

### Modifier Règles Globales

```bash
vim ~/.claude/CLAUDE.md

# Ajouter sections:
## My Custom Rules
...
```

### Commit Changes

```bash
cd ~/.claude
git add .
git commit -m "feat: Add custom command"
git push
```

## 📝 Best Practices

### Workflow Backend + Frontend

```bash
# Backend
mkdir my-project && cd my-project
/init-node-ts
# Config: pnpm, my-backend, ESLint+Prettier

# Frontend (dans même repo ou séparé)
cd ..
/new-front-app
# Config: pnpm, React, my-frontend, React Router
```

### Workflow Fullstack Monorepo

```bash
mkdir my-app && cd my-app
pnpm init

# Structure packages
mkdir -p packages/{frontend,backend}

cd packages/backend
/init-node-ts
# Config: pnpm, backend, ESLint

cd ../frontend
/new-front-app
# Config: pnpm, Next.js, frontend

# Root pnpm-workspace.yaml
cd ../..
echo "packages:\n  - 'packages/*'" > pnpm-workspace.yaml
pnpm install
```

## 🎯 Philosophy

### Token Efficiency
- Commands génèrent code minimal mais fonctionnel
- Best practices intégrées (pas de config manuelle)
- Outils officiels (frameworks maintiennent)

### Zero Config
- `/init-node-ts` : tsc simple et fiable
- `/new-front-app` : Vite/bundler pré-configuré par framework
- Pas de config custom inutile

### Separation of Concerns
- **Backend** : `/init-node-ts` (Node/TS pur, tsc)
- **Frontend** : `/new-front-app` (Vite/framework bundler)
- Pas de mixing (Vite pour backend = overkill)

## 📚 Resources

- [Claude Code Docs](https://claude.com/claude-code)
- [Claude API](https://docs.anthropic.com/)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- [Vite Guide](https://vitejs.dev/guide/)

## 🤝 Contributing

Config personnelle mais PRs welcome pour:
- Nouvelles commandes utiles
- Améliorations best practices
- Corrections bugs

## 📄 License

MIT - Use freely

---

**Maintainer**: [@kevpdev](https://github.com/kevpdev)
**Last Updated**: 2025-12-15
