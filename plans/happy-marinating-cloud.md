# Plan: Rendre template story.md plus succinct

## Problème
Stories générées trop verbeuses avec exemples de code complets. Consomme trop de tokens. Besoin d'un template minimaliste avec juste le cadre nécessaire.

## Exemple actuel (trop verbeux)
Fichier: `GMAIL-001-oauth2-auth.md` et `AI-002-openrouter-client.md`

**Problèmes identifiés:**
- Exemples de code complets (30-60 lignes)
- Sections détaillées: Security Considerations, Setup Prerequisites, Implementation Notes avec code
- Algorithmes détaillés avec pseudo-code
- Retry logic avec code d'exemple
- Logging examples avec code

**Verbosité totale:** ~100-170 lignes par story

## Objectif
Template succinct : ~30-50 lignes max par story

**Garder:**
- Titre + Status + Priority
- Context minimal (pourquoi, parent)
- Implementation Scope: fichiers + fonctions (SANS code)
- Acceptance Criteria (liste simple)
- Dependencies
- Notes techniques (1-2 lignes max)

**Supprimer:**
- Exemples de code
- Sections détaillées (Security, Setup, Algorithm avec code)
- User Need (redondant avec Context)
- Test Scenarios détaillés (acceptance criteria suffit)

## Nouveau template story.md

```markdown
# [STORY-ID] Story Title

**Status**: Not Started
**Priority**: [High/Medium/Low]
**Effort**: [X hours]

## Context

**Parent:** [parent plan file]
**Why:** [1 phrase: user need ou business value]

## Scope

**Files:**
- path/to/file.ts

**Key Functions:**
- functionName() - [what it does]

## Acceptance Criteria

- [ ] Criterion 1
- [ ] Criterion 2
- [ ] TypeScript compiles

## Dependencies

**Blocks**: [story IDs]
**Blocked by**: [story IDs]

## Notes

[Technical notes if needed, 1-2 lignes max]
```

## Fichiers à modifier

### 1. Template
`~/.claude/templates/memory-bank/story.md` - Remplacer par version succincte

### 2. Commande plan-to-stories
`~/.claude/commands/plan-to-stories.md` - Ajuster instructions pour générer stories succinctes:
- Pas d'exemples de code
- Pas de sections détaillées
- Focus sur le cadre minimal

### 3. Commande story-create
`~/.claude/commands/story-create.md` - Simplifier prompts:
- Retirer prompts pour test scenarios détaillés
- Retirer prompts pour security/performance détaillés
- Garder seulement: ID, title, why, files, functions, acceptance criteria, deps

### 4. Guide
`~/.claude/MEMORY-BANK-GUIDE.md` - Mettre à jour exemple de story pour refléter format succinct

## Validation

Story succincte = ~30-50 lignes:
- 3 lignes header (title, status, priority, effort)
- 5-10 lignes Context + Scope
- 5-10 lignes Acceptance Criteria
- 3-5 lignes Dependencies
- 0-5 lignes Notes

**vs ancien format:** ~100-170 lignes

**Économie tokens:** ~60-70% réduction
