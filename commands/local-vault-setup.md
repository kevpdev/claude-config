---
description: Installe l'intégration vault Obsidian dans le projet courant
argument-hint: []
---

Configure l'accès au vault Obsidian pour le projet courant : commandes `/vault:*`, synchronisation de docs, et accès `@fichier`.

## Étape 1 — Vérifier $OBSIDIAN_VAULT_PRO

Exécute `echo $OBSIDIAN_VAULT_PRO`.

Si vide ou non définie, afficher :

```
❌ Variable $OBSIDIAN_VAULT_PRO non définie.

Ajoute cette ligne à ton ~/.zshrc :
  export OBSIDIAN_VAULT_PRO="/chemin/absolu/vers/MyObsidianProVault"

Puis recharge :
  source ~/.zshrc

Relance ensuite /vault-setup.
```

S'arrêter ici.

## Étape 2 — Installer le symlink des commandes vault

Vérifier si `.claude/commands/vault` existe déjà dans le répertoire courant.

- Si oui et que c'est déjà un symlink valide vers `$OBSIDIAN_VAULT_PRO/.claude/commands/vault` → afficher `✅ Commandes vault déjà liées.` et passer à l'étape suivante.
- Si oui mais cassé ou différent → le supprimer et recréer.
- Si non → créer le répertoire `.claude/commands/` si absent, puis créer le symlink :

```bash
mkdir -p .claude/commands
ln -s "$OBSIDIAN_VAULT_PRO/.claude/commands/vault" .claude/commands/vault
```

Afficher :
```
✅ Commandes vault installées → /vault:capture, /vault:new-project, /vault:query, etc.
```

## Étape 3 — Vérifier l'accès @ au vault

Exécute :
```bash
ps aux | grep "claude.*add-dir.*OBSIDIAN" | grep -v grep
```

Si Claude Code n'a pas été lancé avec `--add-dir $OBSIDIAN_VAULT_PRO`, afficher une seule fois :

```
💡 Pour accéder aux fichiers vault via @, lance Claude Code avec :
   claude --add-dir "$OBSIDIAN_VAULT_PRO"

   Ou ajoute un alias dans ton ~/.zshrc :
   alias claude-vault='claude --add-dir "$OBSIDIAN_VAULT_PRO"'
```

## Étape 4 — Résumé

Afficher un récapitulatif :

```
🔗 Vault setup terminé pour ce projet

  Commandes : /vault:capture, /vault:new-project, /vault:query...
  Accès @    : relancer avec --add-dir (voir ci-dessus si non fait)
```
