---
name: vaultx-save
description: >
  Clôture de session vault depuis une session HORS vault (CWD = repo de dev). Pont vers le skill
  canonique vault-save : régénère les fichiers auto-générés et rédige le recap, le tout à la racine
  absolue du vault. Utiliser quand : "save", "fin de session", "clôturer" depuis un repo, "/vaultx:save".
---

# Commande : /vaultx:save

Shim externe. **Tu n'es PAS dans le vault** : le CWD est un repo de dev, le vault est ailleurs.

- **Racine vault** : `$OBSIDIAN_VAULT_PRO`.
- **Skill canonique à exécuter** : `$OBSIDIAN_VAULT_PRO/agent/skills/save/SKILL.md`.

## Adaptation (raison : le SKILL.md lance des `bash scripts/...` et écrit en relatif, faux ici)

1. Lis et suis les instructions de `$OBSIDIAN_VAULT_PRO/agent/skills/save/SKILL.md`.
2. **Lance tout script depuis la racine du vault** :
   ```
   bash -lc 'cd "$OBSIDIAN_VAULT_PRO" && bash scripts/vault-stats.sh'
   bash -lc 'cd "$OBSIDIAN_VAULT_PRO" && bash scripts/regen-all.sh "$OBSIDIAN_VAULT_PRO"'
   ```
3. **Toute écriture va sous la racine absolue**, jamais dans le repo courant :
   recap → `$OBSIDIAN_VAULT_PRO/scripts/logs/sessions/<date>.md` ;
   decisions/CHANGELOG → `$OBSIDIAN_VAULT_PRO/scripts/logs/`.
   Date : `bash -lc 'date +%F'`.
4. Nuance recap : la session porte sur un **repo externe**. Source le travail depuis ce repo
   (git log/diff, fichiers touchés), mais écris le recap **dans le vault**.
