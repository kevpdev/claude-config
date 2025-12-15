# Plan: Commandes Frontend App Scaffolding

## Objectif
Créer des slash commands pour initialiser rapidement des projets frontend avec leurs outils officiels, au lieu d'ajouter Vite à `/init-node-ts` (qui reste backend-only).

## Rationale
- `/init-node-ts` = Backend Node/TS pur (simple, tsc)
- Frontend apps = Besoin Vite/Webpack + framework-specific config
- Meilleur pattern : Utiliser les scaffolding tools officiels de chaque framework

## Commandes à Créer

### 1. `/new-front-app` (Générique)
**Fichier** : `/home/kevdev/.claude/commands/new-front-app.md`

**Comportement** :
1. Ask user: Quel framework ? (Vue/React/Angular/Next/Nuxt/Svelte)
2. Demander nom du projet
3. Exécuter le scaffold officiel selon choix
4. cd dans le projet
5. Installer dépendances
6. Afficher next steps

**Scaffolds utilisés** :
- Vue : `npm create vue@latest`
- React : `npm create vite@latest -- --template react-ts`
- Angular : `npx @angular/cli new`
- Next : `npx create-next-app@latest`
- Nuxt : `npx nuxi init`
- Svelte : `npm create vite@latest -- --template svelte-ts`

### 2. `/new-vue-app` (Direct)
**Fichier** : `/home/kevdev/.claude/commands/new-vue-app.md`

**Comportement** :
1. Ask project name
2. Run `npm create vue@latest <project-name>`
3. Options interactives de create-vue :
   - TypeScript? → Yes (recommended)
   - JSX Support? → No (default)
   - Vue Router? → Yes
   - Pinia? → Yes
   - Vitest? → Yes
   - ESLint? → Yes
   - Prettier? → Yes
4. cd + install + show next steps

**Output** :
```
✓ Vue 3 project created with Vite
✓ TypeScript, Router, Pinia, Vitest, ESLint, Prettier configured
✓ Dependencies installed

Next steps:
  cd <project-name>
  npm run dev
```

### 3. `/new-react-app` (Direct)
**Fichier** : `/home/kevdev/.claude/commands/new-react-app.md`

**Comportement** :
1. Ask project name
2. Ask: React Router? (yes/no)
3. Run `npm create vite@latest <project-name> -- --template react-ts`
4. If React Router: Install + basic setup
5. cd + install + show next steps

**Template** : `react-ts` (React + TypeScript + Vite)

**Optional additions** :
- React Router (`react-router-dom`)
- TanStack Query (if user wants)

### 4. `/new-next-app` (Direct)
**Fichier** : `/home/kevdev/.claude/commands/new-next-app.md`

**Comportement** :
1. Ask project name
2. Run `npx create-next-app@latest <project-name>`
3. Options de create-next-app :
   - TypeScript? → Yes
   - ESLint? → Yes
   - Tailwind CSS? → Ask user
   - `src/` directory? → Yes
   - App Router? → Yes (recommended)
   - Turbopack? → No (beta)
4. cd + show next steps (install auto par create-next-app)

### 5. `/new-nuxt-app` (Direct)
**Fichier** : `/home/kevdev/.claude/commands/new-nuxt-app.md`

**Comportement** :
1. Ask project name
2. Run `npx nuxi init <project-name>`
3. cd + install dependencies
4. Ask: Add modules? (Tailwind, Content, etc.)
5. Show next steps

### 6. `/new-angular-app` (Direct) - Optionnel
**Fichier** : `/home/kevdev/.claude/commands/new-angular-app.md`

**Comportement** :
1. Check if @angular/cli installed globally
2. Ask project name
3. Run `npx @angular/cli new <project-name>`
4. Options Angular CLI :
   - Routing? → Yes
   - Stylesheet format? → SCSS
5. cd + show next steps

## Structure Commune des Commandes

Chaque commande suit ce pattern :

```markdown
---
description: Initialize <Framework> app with official scaffolding tool
---

Initialize a new <Framework> project using the official <tool-name>.

## What this does

- Runs the official <Framework> scaffolding tool
- Configures TypeScript, linting, testing (if available)
- Installs dependencies
- Shows next steps

## Steps

1. **Ask project name** (using AskUserQuestion or direct input)

2. **Ask framework options** (if applicable):
   - Router/State management
   - CSS framework
   - Testing tools

3. **Run official scaffolding command**:
   - Execute via Bash tool
   - Pass options as CLI flags (non-interactive if possible)

4. **Post-setup** (if needed):
   - Install additional packages (if user opted in)
   - Create basic structure/examples
   - Update configs

5. **Verify and show next steps**:
   - cd <project-name>
   - npm run dev (or equivalent)
   - Link to framework docs

## Output

```
🚀 Creating <Framework> app...

✓ Project scaffolded with <official-tool>
✓ TypeScript configured
✓ <Feature1> installed
✓ <Feature2> configured
✓ Dependencies installed

Next steps:
  cd <project-name>
  npm run dev

Open http://localhost:<port>

Docs: <framework-docs-url>
```

## Usage

```bash
/new-<framework>-app
# or
/new-front-app  # Generic with framework choice
```
```

## Priorité de Création

Basé sur usage commun :

1. **Priority 1** (créer d'abord) :
   - `/new-front-app` (générique, couvre tout)
   - `/new-react-app` (très utilisé)
   - `/new-next-app` (React SSR/fullstack populaire)

2. **Priority 2** (ensuite) :
   - `/new-vue-app` (si vous utilisez Vue)
   - `/new-nuxt-app` (Vue SSR/fullstack)

3. **Priority 3** (optionnel) :
   - `/new-angular-app` (si vous utilisez Angular)
   - `/new-svelte-app` (Svelte + Vite)

## Avantages vs Vite dans init-node-ts

| Aspect | Vite in init-node-ts | Commandes Frontend Séparées |
|--------|----------------------|----------------------------|
| **Séparation concerns** | ❌ Backend + Frontend mélangés | ✅ Backend vs Frontend clair |
| **Config Vite** | ⚠️ Manuelle (vite.config.ts) | ✅ Auto (frameworks officiels) |
| **Best practices** | ⚠️ Générique | ✅ Framework-specific |
| **Maintenance** | ⚠️ Doit suivre évolutions Vite | ✅ Tools officiels se mettent à jour |
| **Simplicité init-node-ts** | ❌ Complexifié | ✅ Reste simple (backend only) |
| **DX** | ⚠️ Doit tout configurer | ✅ Zero-config, marche out-of-box |

## Modifications à NE PAS Faire

- ❌ Ne PAS modifier `/init-node-ts` pour ajouter Vite
- ✅ Garder `/init-node-ts` simple : Backend Node/TS avec tsc

## Exemple : /new-react-app Détaillé

**Fichier** : `/home/kevdev/.claude/commands/new-react-app.md`

```markdown
---
description: Initialize React + TypeScript app with Vite
---

Initialize a new React + TypeScript project using Vite's official template.

## What this does

- Creates React 18+ app with Vite
- TypeScript strict mode
- ESLint configured
- Fast HMR with Vite
- Optional: React Router, TanStack Query

## Steps

1. **Ask user preferences**:
   - Project name (required)
   - Add React Router? (yes/no)
   - Add TanStack Query? (yes/no, only if Router = yes)

2. **Create Vite project**:
   ```bash
   npm create vite@latest <project-name> -- --template react-ts
   ```

3. **Navigate to project**:
   ```bash
   cd <project-name>
   ```

4. **Install dependencies**:
   ```bash
   npm install
   ```

5. **Install optional packages** (if user opted in):
   - React Router: `npm install react-router-dom`
   - TanStack Query: `npm install @tanstack/react-query`

6. **Setup React Router** (if chosen):
   - Create `src/routes/` directory
   - Add basic router setup in `src/main.tsx`
   - Create example routes

7. **Show next steps**:
   ```
   ✓ React + Vite project created
   ✓ TypeScript configured
   ✓ React Router installed (if applicable)

   Next steps:
     cd <project-name>
     npm run dev

   Open http://localhost:5173
   Docs: https://react.dev
   ```

## Usage

```bash
/new-react-app

# Interactive:
? Project name: my-react-app
? Add React Router? Yes
? Add TanStack Query? Yes

🚀 Creating React app...
✓ Project created with Vite
✓ React Router installed
✓ TanStack Query installed
✓ Dependencies installed

Next: cd my-react-app && npm run dev
```

## Integration

Works independently from `/init-node-ts` (which is backend-only).

For fullstack apps:
- Frontend: `/new-react-app` (or /new-next-app for SSR)
- Backend: `/init-node-ts` (separate directory or monorepo)

## Notes

- Uses official Vite template (maintained by Vite team)
- React 18+ with latest features (Suspense, Concurrent rendering)
- Vite config pre-optimized for React
- No need for manual Vite setup
```

## Decision Finale

**Créer uniquement** : `/new-front-app` (générique)

**Rationale** :
- ✅ Une commande couvre tous les frameworks
- ✅ Flexibilité maximale (ajout facile de frameworks)
- ✅ Moins de maintenance (1 fichier vs 5+)
- ✅ Peut ajouter shortcuts spécifiques plus tard si besoin

## Implémentation : `/new-front-app`

**Fichier** : `/home/kevdev/.claude/commands/new-front-app.md`

### Workflow Détaillé

1. **Ask framework** (AskUserQuestion):
   ```typescript
   {
     question: "Quel framework frontend ?",
     header: "Framework",
     options: [
       { label: "React", description: "React 18 + Vite + TypeScript" },
       { label: "Vue", description: "Vue 3 + Vite + TypeScript + Router + Pinia" },
       { label: "Next.js", description: "React SSR/SSG + App Router" },
       { label: "Nuxt", description: "Vue SSR/SSG + Auto-imports" },
       { label: "Svelte", description: "Svelte + Vite + TypeScript" },
       { label: "Angular", description: "Angular + TypeScript + Router" }
     ]
   }
   ```

2. **Ask project name**:
   - Default: current directory name
   - Validate: no spaces, lowercase

3. **Execute scaffold** (selon framework choisi):

   **React**:
   ```bash
   npm create vite@latest <project-name> -- --template react-ts
   cd <project-name>
   npm install
   ```
   Ask: Add React Router? → `npm install react-router-dom`

   **Vue**:
   ```bash
   npm create vue@latest <project-name> -- --typescript --router --pinia --vitest --eslint
   cd <project-name>
   npm install
   ```

   **Next.js**:
   ```bash
   npx create-next-app@latest <project-name> --typescript --eslint --src-dir --app --no-turbopack
   cd <project-name>
   # dependencies auto-installed
   ```
   Ask: Add Tailwind? → Already in create-next-app options

   **Nuxt**:
   ```bash
   npx nuxi init <project-name>
   cd <project-name>
   npm install
   ```
   Ask: Add Tailwind module? → `npx nuxi module add @nuxtjs/tailwindcss`

   **Svelte**:
   ```bash
   npm create vite@latest <project-name> -- --template svelte-ts
   cd <project-name>
   npm install
   ```

   **Angular**:
   ```bash
   npx @angular/cli new <project-name> --routing --style=scss --strict
   cd <project-name>
   # dependencies auto-installed
   ```

4. **Show summary**:
   ```
   ✓ <Framework> project created
   ✓ TypeScript configured
   ✓ [Framework-specific features] installed

   Next steps:
     cd <project-name>
     npm run dev

   Open http://localhost:<port>
   Docs: <framework-docs-url>
   ```

### Commande Complète

```markdown
---
description: Initialize frontend app with framework of choice
---

Initialize a new frontend project using official scaffolding tools.

## What this does

Asks for your preferred framework (React/Vue/Next/Nuxt/Svelte/Angular) and creates a production-ready project with:
- TypeScript strict mode
- Vite (React/Vue/Svelte) or framework bundler (Next/Nuxt/Angular)
- ESLint + framework-specific linting
- Testing tools (Vitest for Vue, Jest/Testing Library for React)
- Official best practices

## Steps

1. **Ask framework choice** (using AskUserQuestion):
   - React (Vite + React 18 + TypeScript)
   - Vue (Vue 3 + Router + Pinia + Vitest)
   - Next.js (SSR/SSG + App Router)
   - Nuxt (SSR/SSG + Auto-imports)
   - Svelte (Vite + Svelte 4 + TypeScript)
   - Angular (Angular 17+ + Router)

2. **Ask project name**:
   - Validate name (lowercase, no spaces)
   - Default to current directory name

3. **Run official scaffolding tool**:
   - React: `npm create vite@latest -- --template react-ts`
   - Vue: `npm create vue@latest -- --typescript --router --pinia --vitest --eslint`
   - Next: `npx create-next-app@latest -- --typescript --eslint --src-dir --app`
   - Nuxt: `npx nuxi init`
   - Svelte: `npm create vite@latest -- --template svelte-ts`
   - Angular: `npx @angular/cli new -- --routing --style=scss --strict`

4. **Navigate to project**: `cd <project-name>`

5. **Install dependencies** (if not auto-installed):
   - React/Vue/Svelte: `npm install`
   - Next/Angular: Auto-installed by CLI

6. **Ask framework-specific options**:
   - React: Add React Router? → `npm install react-router-dom`
   - Vue: Already includes Router + Pinia
   - Next: Tailwind already in options
   - Nuxt: Add Tailwind module? → `npx nuxi module add @nuxtjs/tailwindcss`
   - Svelte: Add SvelteKit for routing? (upgrade command)
   - Angular: Already includes Router

7. **Verify setup**:
   - Check package.json exists
   - Check TypeScript config exists
   - List available scripts

8. **Show next steps**:
   ```
   ✓ <Framework> project created successfully
   ✓ TypeScript configured (strict mode)
   ✓ <Features> installed
   ✓ Dependencies installed

   Next steps:
     cd <project-name>
     npm run dev    # Start dev server

   Development:
     - React: http://localhost:5173
     - Vue: http://localhost:5173
     - Next: http://localhost:3000
     - Nuxt: http://localhost:3000
     - Svelte: http://localhost:5173
     - Angular: http://localhost:4200

   Documentation:
     - React: https://react.dev
     - Vue: https://vuejs.org
     - Next: https://nextjs.org/docs
     - Nuxt: https://nuxt.com/docs
     - Svelte: https://svelte.dev
     - Angular: https://angular.dev
   ```

## Usage

```bash
/new-front-app

# Interactive prompts:
? Framework: React
? Project name: my-app
? Add React Router? Yes

🚀 Creating React app...
✓ Project created with Vite
✓ React Router installed
✓ Dependencies installed

Next: cd my-app && npm run dev
```

## Integration

- **Standalone**: Creates new frontend project
- **Fullstack**: Combine with `/init-node-ts` for backend
  - Frontend: `/new-front-app`
  - Backend: `/init-node-ts` (separate dir or monorepo)

## Notes

- Uses official tools (best practices guaranteed)
- TypeScript strict mode by default
- Vite for fast HMR (React/Vue/Svelte)
- Framework bundlers for Next/Nuxt/Angular
- No manual Vite config needed
- Can add more frameworks later easily
```

## Next Steps (Implémentation)

1. Créer `/home/kevdev/.claude/commands/new-front-app.md`
2. Tester avec chaque framework (au moins React, Vue, Next)
3. Vérifier que les scaffolds s'exécutent correctement
4. Ajouter dans documentation/workflow si nécessaire
5. Optionnel : Ajouter shortcuts spécifiques (`/new-react-app`, etc.) plus tard
