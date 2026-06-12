---
name: vaultx-load
description: >
  Charge le contexte du vault depuis une session HORS vault (CWD = repo de dev). Pont vers le
  skill canonique vault-load, scripts lancés à la racine absolue du vault. Mode global (sans arg)
  ou task-scoped (<task-id>). Utiliser quand : "charge le contexte vault", "/vaultx:load [id]".
---

# Commande : /vaultx:load [task-id]

Shim externe. **Tu n'es PAS dans le vault** : le CWD est un repo de dev, le vault est ailleurs.

- **Racine vault** : `$OBSIDIAN_VAULT_PRO`.
- **Skill canonique à exécuter** : `$OBSIDIAN_VAULT_PRO/agent/skills/load/SKILL.md`.

## Adaptation (raison : le SKILL.md lance `bash scripts/load.sh` en relatif, faux ici)

1. Lis et suis les instructions de `$OBSIDIAN_VAULT_PRO/agent/skills/load/SKILL.md`.
2. **Lance tout script depuis la racine du vault**, pas depuis le repo :
   ```
   bash -lc 'cd "$OBSIDIAN_VAULT_PRO" && bash scripts/load.sh'          # mode global
   bash -lc 'cd "$OBSIDIAN_VAULT_PRO" && bash scripts/load.sh <task-id>' # mode task-scoped
   ```
3. Résume à l'utilisateur le contexte chargé (sprint/priorités, ou tâche/statut/blockers/next).
4. Signale tout mode dégradé remonté par le script (id introuvable, liens cassés) — no silent degradation.
