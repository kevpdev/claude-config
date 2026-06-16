---
name: local-vault-recall
description: >
  Interroge le vault Obsidian perso (connaissance, raisonnement, décisions, journal) DEPUIS une
  session hors-vault (CWD = repo dev ou autre). Lecture seule : grep, lit, synthétise, cite ses
  sources. Utiliser quand : "qu'est-ce que le vault dit sur X", "retrouve dans mes notes", "j'ai
  un besoin ponctuel de connaissance du vault", "cherche dans le vault". NE PAS utiliser pour
  écrire dans le vault (capture/save/refresh → faire ça en session `ccvault`), ni pour la vérité
  projet d'un repo (→ son `aidd_docs/`).
---

# Skill — Vault Recall (lecture seule)

## Rôle

Atteindre le **vault perso** (extension mémoire : explo, raisonnement, décisions, journal) à la
demande, depuis n'importe quelle session, **sans écrire**. Le vault n'est plus injecté partout : on
le consulte quand *le cerveau* en a besoin, pas quand *le code* en a besoin.

**POURQUOI lecture seule** : l'écriture vault (capture, save, refresh, nouveaux objets) se fait en
session `ccvault` (CWD = vault), là où les conventions et hooks vault s'appliquent. Écrire depuis
une session dev court-circuiterait ces garde-fous et créerait des notes hors-cadre.

## Racine du vault

Toujours via la variable d'environnement, en chemins absolus :

```bash
echo "$OBSIDIAN_VAULT_PRO"   # /home/kevin/projects/BetterflyWorkspace/MyObsidianProVault
```

Les scripts et greps du vault supposent un CWD = racine vault → les lancer dans un sous-shell
rooté, jamais en changeant le CWD de la session :

```bash
(cd "$OBSIDIAN_VAULT_PRO" && <commande vault>)
```

## Méthode

1. **Chercher** (grep, rooté vault) :
   ```bash
   (cd "$OBSIDIAN_VAULT_PRO" && grep -ril "<mots-clés>" . \
     --include="*.md" \
     --exclude-dir=".claude" --exclude-dir="templates" \
     --exclude-dir="scripts" --exclude-dir="agent")
   ```
2. **Lire** les 5 notes les plus pertinentes (chemins absolus sous `$OBSIDIAN_VAULT_PRO`). Si la
   question porte sur le vault lui-même → commencer par `$OBSIDIAN_VAULT_PRO/INDEX.md` ou `HOME.md`.
3. **Synthétiser** : réponse structurée fondée **uniquement** sur le contenu lu, source citée
   systématiquement : `(source : [[chemin/note]])`.

### Réutiliser les commandes de lecture du vault

Le vault porte ses propres instructions de lecture. Pour une requête riche, lire et appliquer
l'instruction correspondante (chemins absolus) plutôt que réinventer :

| Besoin | Instruction / script (racine = `$OBSIDIAN_VAULT_PRO`) |
|---|---|
| Recherche + synthèse | `agent/skills/query/SKILL.md` |
| Contexte de session / tâche | `agent/skills/load/SKILL.md` (`bash scripts/load.sh`) |
| Lint / cohérence | `agent/skills/lint/SKILL.md` |
| Diagnostic vault | `agent/skills/doctor/SKILL.md` |
| Stats | `bash scripts/vault-stats.sh` |

Exécuter un script vault rooté : `(cd "$OBSIDIAN_VAULT_PRO" && bash scripts/<x>.sh)`.

## Garde-fou écriture (strict)

**INTERDIT** depuis ce skill — aucune écriture vault, directe ou via commande :
- `/vault:capture`, `/vault:save`, tout `/vault:refresh-*`, `/vault:archive`, `/vault:new-*`,
  `/vault:journal`, `/vault:triage`
- Toute écriture sous `$OBSIDIAN_VAULT_PRO/0_INBOX/` ou `3_KNOWLEDGE/`
- Tout `Write`/`Edit`/`mv`/`rm` ciblant un fichier du vault

**À LA PLACE** : si une capture ou une mise à jour s'impose, le dire et inviter l'utilisateur à
basculer en session `ccvault` (ou à utiliser `/vault:capture` lui-même). Ce skill **restitue**, il
n'écrit pas.

## Frontière

- Vérité projet d'un repo (état, décision tranchée, spec) → son `aidd_docs/`, **pas** ce skill.
- Ce skill = le *pourquoi* / la connaissance perso (vault). `local-vault-setup` (commande) installe
  un symlink persistant des commandes vault par projet ; ce skill = recall ad-hoc, sans setup.
