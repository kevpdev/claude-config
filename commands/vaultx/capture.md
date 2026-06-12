---
name: vaultx-capture
description: >
  Capture vault depuis une session HORS vault (CWD = repo de dev). Pont vers le skill
  canonique vault-capture, avec résolution des chemins contre la racine absolue du vault.
  Utiliser quand : "capture", "note rapide", "enregistre ça" depuis un repo, "/vaultx:capture".
---

# Commande : /vaultx:capture

Shim externe. **Tu n'es PAS dans le vault** : le CWD est un repo de dev, le vault est ailleurs.

- **Racine vault** : `$OBSIDIAN_VAULT_PRO` (chemin absolu, dispo dans le shell).
- **Skill canonique à exécuter** : `$OBSIDIAN_VAULT_PRO/agent/skills/capture/SKILL.md`.

## Adaptation (raison : le SKILL.md suppose CWD=vault, faux ici)

1. Lis et suis les instructions de `$OBSIDIAN_VAULT_PRO/agent/skills/capture/SKILL.md`.
2. **Résous tout chemin relatif contre la racine absolue.** Le fichier d'inbox se crée dans
   `$OBSIDIAN_VAULT_PRO/0_INBOX/`, **jamais** dans le repo courant (sinon capture perdue).
3. Pour la date du nom de fichier (`YYYY-MM-DD`) : `bash -lc 'date +%F'`.
4. Confirme à l'utilisateur le chemin absolu créé.
