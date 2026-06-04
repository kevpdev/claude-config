## Règle absolue — Demander avant d'implémenter

**INTERDIT**
- Écrire ou modifier du code sans "go ahead" explicite — même en mode bypass, même si la question appelle une implémentation directe

**AUTORISÉ**
- Proposer, expliquer, puis attendre la validation avant de toucher un fichier

## Memory-Bank & Workflows

Le contexte de session (Focus, Next Steps) est chargé automatiquement par le hook `SessionStart`.
Les skills pertinents sont proposés à chaque prompt par le hook `UserPromptSubmit` (routing déterministe `config/agent-routing.json`).

### Workflow quotidien
- **Début** : `/session-start` — confirme le focus ou en fixe un nouveau
- **En cours** : `/capture "note"` — capture sans casser le flow
- **Fin** : `/session-end` — sauvegarde progress et next steps

### Commandes principales
| Commande | Usage |
|---|---|
| `/session-start` · `/session-end` | Charge / sauvegarde le contexte de session |
| `/capture` | Note rapide sans interrompre le flow |
| `/memory-bank-init` · `/memory-bank-setup` | Initialise / configure le memory-bank projet |
| `/plan` → `/epct` | Plan (s'arrête avant le code) puis implémentation |
| `/create-pull-request` | PR avec titre + description auto |
| `/skill <nom>` | Charge manuellement un skill (sinon auto-proposé) |

### Skills
Source de vérité = le dossier `skills/` + `config/agent-routing.json`. Pas de liste figée ici (elle dériverait) ; les skills sont auto-proposés selon le prompt, ou chargés via `/skill <nom>`.
