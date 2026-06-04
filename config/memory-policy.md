## Auto-memory ↔ vault — couche projet (conditionnelle)

Auto-memory, catégorie « projet » (`project_*`) : autorisée **par défaut**. **MAIS** si le workspace courant déclare un vault (signal : MOC vault dans le workspace **ou** `_claudeTeam.vaultRoot` dans les settings) → le **vault est la source de vérité unique** de la couche projet :

- Ne JAMAIS écrire un fait projet (état, décision, tâche, contexte, chantier) en auto-memory `project_*` — il vit dans le vault, surfacé au parent par le hook `SessionStart`.
- L'auto-memory ne garde que le **parent-only sans équivalent vault** : profil user (`user_*`), config dev / référence (`reference_*`), feedback parent-only (`feedback_*`).
- **Règles et feedback fork-pertinents** → `CLAUDE.md` (ou un de ses fichiers importés), seul store qui traverse un contexte isolé (sous-agent, skill `context: fork`). Jamais dans le vault : un fork ne le lit pas.

Le type `project` est donc **suspendu** tant qu'un vault est présent — même si la doc Claude recommande l'auto-memory projet, cette reco suppose l'absence de vault. Gating **probabiliste** (évalué par Claude, pas un hook) : coût d'un raté = une mémoire stale, faible et différé.
