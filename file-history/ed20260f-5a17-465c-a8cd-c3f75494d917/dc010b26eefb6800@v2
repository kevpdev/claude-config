---
description: Initialize frontend app with framework of choice
argument-hint: [project-name]
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

1. **Ask user preferences** (using AskUserQuestion):
   - Package manager (pnpm/npm/yarn)
   - Framework choice:
     - React (Vite + React 18 + TypeScript)
     - Vue (Vue 3 + Router + Pinia + Vitest)
     - Next.js (SSR/SSG + App Router)
     - Nuxt (SSR/SSG + Auto-imports)
     - Svelte (Vite + Svelte 4 + TypeScript)
     - Angular (Angular 17+ + Router)

2. **Ask project name**:
   - If provided as argument, use it
   - Otherwise ask user
   - Validate name (lowercase, no spaces)
   - Default to current directory name if not provided

3. **Run official scaffolding tool** (based on framework and package manager choice):

   **React**:
   ```bash
   # pnpm
   pnpm create vite <project-name> --template react-ts
   cd <project-name>
   pnpm install

   # npm
   npm create vite@latest <project-name> -- --template react-ts
   cd <project-name>
   npm install

   # yarn
   yarn create vite <project-name> --template react-ts
   cd <project-name>
   yarn
   ```
   Then ask: Add React Router? If yes: `<pm> add react-router-dom` (pm = package manager)

   **Vue**:
   ```bash
   # pnpm
   pnpm create vue <project-name> --typescript --router --pinia --vitest --eslint
   cd <project-name>
   pnpm install

   # npm
   npm create vue@latest <project-name> -- --typescript --router --pinia --vitest --eslint
   cd <project-name>
   npm install

   # yarn
   yarn create vue <project-name> --typescript --router --pinia --vitest --eslint
   cd <project-name>
   yarn
   ```

   **Next.js**:
   ```bash
   # pnpm
   pnpm create next-app <project-name> --typescript --eslint --src-dir --app --no-turbopack
   cd <project-name>
   # dependencies auto-installed

   # npm
   npx create-next-app@latest <project-name> --typescript --eslint --src-dir --app --no-turbopack
   cd <project-name>
   # dependencies auto-installed

   # yarn
   yarn create next-app <project-name> --typescript --eslint --src-dir --app --no-turbopack
   cd <project-name>
   # dependencies auto-installed
   ```
   Then ask: Add Tailwind? If yes: Already in create-next-app options (use --tailwind flag)

   **Nuxt**:
   ```bash
   # All package managers use npx for nuxi
   npx nuxi init <project-name>
   cd <project-name>

   # Then install with chosen package manager
   pnpm install  # or npm install, or yarn
   ```
   Then ask: Add Tailwind module? If yes: `npx nuxi module add @nuxtjs/tailwindcss`

   **Svelte**:
   ```bash
   # pnpm
   pnpm create vite <project-name> --template svelte-ts
   cd <project-name>
   pnpm install

   # npm
   npm create vite@latest <project-name> -- --template svelte-ts
   cd <project-name>
   npm install

   # yarn
   yarn create vite <project-name> --template svelte-ts
   cd <project-name>
   yarn
   ```

   **Angular**:
   ```bash
   # All package managers use npx for Angular CLI
   npx @angular/cli new <project-name> --routing --style=scss --strict --package-manager=<pm>
   cd <project-name>
   # dependencies auto-installed
   ```
   Note: Angular CLI accepts --package-manager flag (pnpm/npm/yarn)

4. **Navigate to project**: Change directory to the newly created project

5. **Install dependencies** (if not auto-installed):
   - React/Vue/Svelte: Run install command with chosen package manager
     - pnpm: `pnpm install`
     - npm: `npm install`
     - yarn: `yarn`
   - Next/Angular: Already installed by CLI

6. **Ask framework-specific options**:
   - **React**: Add React Router? → If yes, install with package manager:
     - pnpm: `pnpm add react-router-dom`
     - npm: `npm install react-router-dom`
     - yarn: `yarn add react-router-dom`
   - **Vue**: Already includes Router + Pinia (from create-vue flags)
   - **Next**: Tailwind already in create-next-app options
   - **Nuxt**: Add Tailwind module? → If yes, run `npx nuxi module add @nuxtjs/tailwindcss`
   - **Svelte**: No additional options (can add SvelteKit later)
   - **Angular**: Already includes Router (from --routing flag)

7. **Verify setup**:
   - Check package.json exists
   - Check TypeScript config exists (tsconfig.json)
   - List available npm scripts from package.json

8. **Show next steps** with framework-specific info and chosen package manager:
   ```
   ✓ <Framework> project created successfully
   ✓ TypeScript configured (strict mode)
   ✓ <Features> installed
   ✓ Dependencies installed

   Next steps:
     cd <project-name>
     <pm> run dev    # Start dev server (pnpm run dev / npm run dev / yarn dev)

   Development server:
     - React/Vue/Svelte: http://localhost:5173
     - Next: http://localhost:3000
     - Nuxt: http://localhost:3000
     - Angular: http://localhost:4200

   Common commands:
     - pnpm: pnpm run dev, pnpm add <package>, pnpm run build
     - npm: npm run dev, npm install <package>, npm run build
     - yarn: yarn dev, yarn add <package>, yarn build

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
# With project name
/new-front-app my-app

# Interactive (will ask for all options)
/new-front-app

# Example interaction:
? Package manager: pnpm
? Framework: React
? Project name: my-app
? Add React Router? Yes

🚀 Creating React app with pnpm...
✓ Project created with Vite
✓ React Router installed
✓ Dependencies installed

Next: cd my-app && pnpm run dev
```

## Framework Details

### React
- **Tool**: Vite with react-ts template
- **Includes**: React 18, TypeScript, Vite, ESLint
- **Optional**: React Router for routing
- **Dev server**: http://localhost:5173
- **Command**: `npm run dev`

### Vue
- **Tool**: create-vue (official scaffolding)
- **Includes**: Vue 3, TypeScript, Router, Pinia, Vitest, ESLint, Prettier
- **Optional**: N/A (all recommended features included)
- **Dev server**: http://localhost:5173
- **Command**: `npm run dev`

### Next.js
- **Tool**: create-next-app
- **Includes**: Next.js, React, TypeScript, ESLint, App Router, src/ directory
- **Optional**: Tailwind CSS (via --tailwind flag)
- **Dev server**: http://localhost:3000
- **Command**: `npm run dev`

### Nuxt
- **Tool**: nuxi (official Nuxt CLI)
- **Includes**: Nuxt 3, Vue 3, TypeScript, Auto-imports
- **Optional**: Tailwind module (@nuxtjs/tailwindcss)
- **Dev server**: http://localhost:3000
- **Command**: `npm run dev`

### Svelte
- **Tool**: Vite with svelte-ts template
- **Includes**: Svelte 4, TypeScript, Vite
- **Optional**: N/A (can upgrade to SvelteKit later)
- **Dev server**: http://localhost:5173
- **Command**: `npm run dev`

### Angular
- **Tool**: Angular CLI
- **Includes**: Angular 17+, TypeScript, Router, SCSS, Strict mode
- **Optional**: N/A (routing included via --routing flag)
- **Dev server**: http://localhost:4200
- **Command**: `npm start` or `ng serve`

## Integration

### Standalone Frontend
```bash
/new-front-app my-frontend
cd my-frontend
npm run dev
```

### Fullstack (Frontend + Backend)
```bash
# Backend
/init-node-ts my-backend
cd my-backend

# Frontend (in separate directory or monorepo)
cd ..
/new-front-app my-frontend
cd my-frontend
```

### Monorepo Structure
```
my-project/
├── packages/
│   ├── frontend/    # Created with /new-front-app
│   └── backend/     # Created with /init-node-ts
├── package.json     # Workspace root
└── pnpm-workspace.yaml
```

## Notes

- Uses official scaffolding tools (maintained by framework teams)
- TypeScript strict mode enabled by default
- All configurations follow framework best practices
- No manual Vite config needed (already optimized)
- Can add more frameworks later by extending Step 3
- Compatible with all major package managers (npm/yarn/pnpm)

## Tips

1. **Choosing a Package Manager**:
   - **pnpm**: Fastest, most disk-efficient, strict node_modules (recommended)
   - **npm**: Default, most compatible, largest ecosystem
   - **yarn**: Fast, good DX, lockfile stability

2. **Choosing a Framework**:
   - **React**: Largest ecosystem, most jobs, component-focused
   - **Vue**: Progressive, easy to learn, excellent docs
   - **Next.js**: React + SSR/SSG, excellent for SEO, fullstack
   - **Nuxt**: Vue + SSR/SSG, auto-imports, great DX
   - **Svelte**: Smallest bundles, compiler-based, simple syntax
   - **Angular**: Enterprise-ready, full framework, opinionated

3. **React Router**:
   - Say **Yes** if building SPA with multiple pages
   - Say **No** if single-page app or using Next.js (built-in routing)

4. **Tailwind CSS**:
   - Say **Yes** for utility-first CSS (rapid prototyping)
   - Say **No** if prefer custom CSS or other frameworks

5. **After Creation**:
   - Review generated README.md for framework-specific commands
   - Check package.json scripts
   - Explore official documentation for advanced features
