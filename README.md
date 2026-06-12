# claude-config — template `~/.claude` équipe

Configuration Claude Code **clonable, multi-OS, mise à jour par `git pull`**.
Le dépôt se clone directement **en tant que** `~/.claude` : il est à la fois le repo git et le répertoire runtime de Claude Code.

> Branche `claude-config-team` = version épurée, compatible équipe. Distincte de `main` (config perso).

## Ce que contient le template

| Élément | Détail |
|---|---|
| Hooks | `SessionStart` (contexte), `PreToolUse` (guard commit), `SessionEnd` (snapshot) |
| Skills | experts chargeables (`backend-architect`, `frontend-expert`, `security-reviewer`, `docs-check`…) — proposés nativement par le harness ou via `/skill <nom>` |
| Agents | sous-agents délégables (`doc-writer`…) |
| Garde-fou commit | `guard-no-claude-in-commit` bloque toute mention Claude/AI/co-author + impose Conventional Commits EN |
| Templates | scaffolding memory-bank (`projectbrief`, `activeContext`, `story`…) |

## Stratégie de tracking — deny-all whitelist

`~/.claude` héberge aussi tes credentials, `projects/`, `sessions/`, historique. Le `.gitignore` **ignore tout** (`/*`) puis ne ré-inclut que l'arbre template (`agents/`, `commands/`, `config/`, `docs/`, `scripts/`, `skills/`, `templates/`, + `settings.json`, `CLAUDE.md`, `README.md`).

Conséquence : tes fichiers perso ne risquent jamais d'être trackés ni pushés.

## Installation

### Prérequis

| Outil | Statut |
|---|---|
| `git` ≥ 2.x, `bash` | **requis** |
| `jq`, `python3` | **recommandés** — utilisés par certains hooks/scripts (parsing JSON) |

### Cas A — installation propre (pas de `~/.claude`)

```bash
git clone -b claude-config-team git@github.com:kevpdev/claude-config.git ~/.claude
```

C'est tout. Configure ensuite ta **couche perso** (voir plus bas).

### Cas B — `~/.claude` existe déjà

Un `~/.claude` existant contient déjà `settings.json` et `CLAUDE.md` (non trackés). On les **bascule dans la couche perso** avant de poser le template, pour ne rien perdre :

```bash
cd ~/.claude

# 1. sauver ta config perso dans la couche locale (gitignorée)
[ -f settings.json ] && mv settings.json settings.local.json
[ -f CLAUDE.md ]     && mv CLAUDE.md CLAUDE.local.md

# 2. initialiser le repo en place et récupérer la branche
git init
git remote add origin git@github.com:kevpdev/claude-config.git
git fetch origin claude-config-team
git checkout -b claude-config-team origin/claude-config-team
```

Tes préférences migrent dans `settings.local.json` / `CLAUDE.local.md` (chargés **en plus** du template), le template prend la place propre. Vérifie ensuite qu'aucun réglage perso ne manque dans la couche locale.

## Couche perso vs template

3 mécanismes, un par type d'artefact — **tout est gitignoré, survit au `git pull`, jamais pushé** :

| Couche | Artefact perso | Mécanisme |
|---|---|---|
| Settings | `model`, `theme`, flags | `settings.local.json` (deep-merge natif par-dessus `settings.json`) |
| Instructions | style, notes perso | `CLAUDE.local.md` (chargé en plus de `CLAUDE.md`) |
| Commands / Skills | tes commandes/skills perso | convention **préfixe `local-`** (ex. `skills/local-mon-skill/`) — re-ignoré par le `.gitignore` |

> Un skill `local-*` (perso, gitignoré) n'est pas chez un coéquipier : il s'invoque manuellement, ne le câble jamais dans un fichier tracké.

## Mise à jour

```bash
cd ~/.claude && git pull
```

Tes fichiers `local-*`, `settings.local.json` et `CLAUDE.local.md` ne sont jamais touchés.
