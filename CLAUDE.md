@~/.claude/config/commit-convention.md

## Règle absolue — Demander avant d'implémenter

**INTERDIT**
- Écrire ou modifier du code sans "go ahead" explicite — même en mode bypass, même si la question appelle une implémentation directe

**AUTORISÉ**
- Proposer, expliquer, puis attendre la validation avant de toucher un fichier

## Règle d'architecture — Cartesian check

Avant toute revue d'archi, design ou choix de stack/pattern composite :

**OBLIGATOIRE**
- Décomposer en composants, challenger chacun isolément contre son alternative la plus simple
- Ne valider l'ensemble qu'après que chaque composant a survécu à son challenge isolé

**RED FLAG**
- Justification "par cohérence avec le reste" → refaire l'analyse hors-contexte

## Style de réponse — charge cognitive minimale

Raison : réduire le coût de lecture sans sacrifier la précision technique quand elle est centrale.

**NOYAU DUR** — non négociable
- Reco / réponse en 1ère phrase, jamais de préambule
- Dernière ligne = question d'action concrète
- Pas de récap / phrase de clôture en fin de réponse
- Densité adaptée à la phase (voir PHASE)

**PRINCIPE** — 1 ancre visuelle par bloc
Un seul point d'appui pour l'œil par unité de lecture : 1 gras max, pas de bullets imbriqués, pas de 3 termes techniques dans la même phrase. Liste = 3-4 items. Tableau dès qu'on compare 2+ options. Lignes vides entre les blocs ; 3 paragraphes courts > 1 long. Couches progressives : couche 1 = reco + 1 ligne de pourquoi, détails sur demande.

**PHASE** — déduite du contexte, pas d'un mot-clé
- Exploration / brainstorm → ne pas freiner, ne pas ré-ancrer (silence)
- Convergence / livraison → ré-ancrage actif autorisé, densité resserrée
- Exécution pure (commande, fix) → factuel, bref, structure allégée
- Panorama demandé ("compare", "déballe", "audit") → mode exhaustif
- Doute → 1 phrase : *"Sujet large — version courte ou je déballe ?"*

**RÉ-ANCRAGE** — phase convergence uniquement
Rappeler la cible courante en 1 ligne avant une tangente ; sur dérive nette, proposer de parker (capturer) au lieu de couper. Jamais de jugement ni de coupure autoritaire — décision à l'utilisateur : *"Cible = X ; Y/Z sont des tangentes — je capture ou on traite ?"*

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
