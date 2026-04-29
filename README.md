# Claude Code Configuration

Config personnalisée pour [Claude Code](https://claude.com/claude-code).

## Contenu

- **Slash commands** (`commands/`) — workflows courants (`/commit`, `/explore`, `/session-start`…)
- **Règles globales** (`CLAUDE.md` + `rules/`) — git, qualité, sécurité, a11y, testing
- **Hook sécurité** (`scripts/command-validator/`) — bloque les commandes Bash dangereuses
- **Memory-Bank** — persistance de contexte entre sessions (auto-load + auto-snapshot)
- **Agents** (`agents/`) — `backend-architect`, `frontend-expert`, `database-expert`, `security-reviewer`, `code-reviewer`, `doc-writer` (décisions/review/docs), `explore-codebase`, `explore-docs`, `websearch`
- **Templates** (`templates/`)

## Installation

**Prérequis** : Claude Code, **Node.js 24+**, `git`. `ffplay` optionnel (sons).

```bash
mv ~/.claude ~/.claude.backup    # si config existante
git clone https://github.com/kevpdev/claude-config.git ~/.claude
cd ~/.claude/scripts/command-validator && npm install
```

Pas de build : Node 24 exécute le TypeScript nativement.

**Mise à jour** : `cd ~/.claude && git pull && cd scripts/command-validator && npm install`

## Hooks actifs (`settings.json`)

| Hook | Rôle |
|---|---|
| `PreToolUse` (Bash) | Validation sécurité avant chaque commande shell |
| `Stop` | Son de fin de réponse |
| `SessionEnd` | Auto-snapshot du memory-bank |
| `Notification` | Son d'alerte |

## Command Validator

Intercepte chaque commande Bash. Bloque ~50 patterns destructeurs (`rm -rf /etc`, `dd of=/dev/sda`, `curl … | bash`, fork bombs, exfiltration, etc.). Laisse passer le workflow dev classique (`git`, `npm`, `node`, `psql`, `ls`, `cat`, …).

- Règles : `scripts/command-validator/src/lib/security-rules.ts` — modification active immédiatement
- Logs : `scripts/command-validator/data/security.log` (JSONL)
- Type-check : `npm run typecheck`

## Memory-Bank

Persistance de contexte par projet dans `.claude/memory-bank/`. Voir [`MEMORY-BANK-GUIDE.md`](./MEMORY-BANK-GUIDE.md).

| Commande | Rôle |
|---|---|
| `/memory-bank-init` | Crée la structure dans le projet courant |
| `/session-start [goal]` | Charge contexte + objectif |
| `/session-end` | Synthèse interactive de fin de session |
| `/capture "note"` | Note rapide horodatée |

**Automatique** :
- Au démarrage : Claude lit `Current Focus` + `Next Steps` (instruction dans `CLAUDE.md`)
- À la fermeture : `auto-snapshot.sh` met à jour timestamp + fichiers git modifiés (max 10 entrées)

## Customisation

```bash
# Nouvelle commande
echo '---\ndescription: ...\n---\n...' > ~/.claude/commands/my-cmd.md

# Modifier règles globales
$EDITOR ~/.claude/CLAUDE.md
```

## Known Issues / RAF

- 🟡 **Statusline désactivé** (`scripts/statusline/`) — encore en Bun, retiré de `settings.json`. Pour réactiver : migrer vers Node 24 (même approche que `command-validator`), puis ajouter dans `settings.json` :
  ```json
  "statusLine": { "type": "command", "command": "node $HOME/.claude/scripts/statusline/src/index.ts", "padding": 0 }
  ```
- 🟢 Tests automatisés pour `auto-snapshot.sh`
- 🟢 CI : `npm run typecheck` sur PR

## Resources

- [Claude Code Docs](https://claude.com/claude-code) · [Anthropic API](https://docs.anthropic.com/)

## License

MIT — **Maintainer** : [@kevpdev](https://github.com/kevpdev)
