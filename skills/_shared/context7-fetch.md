# Recette partagée — Doc de lib à jour via Context7 v2 (HTTP)

Recette de référence pour récupérer de la documentation de librairie **à jour** via l'API HTTP Context7 v2, sans MCP ni CLI.
Référencée par le skill `docs-check` et par les skills d'expertise (backend, frontend, agentic, etc.).

## Quand l'utiliser

Déclencher **uniquement** en cas de doute réel :
- Signature / API exacte d'une méthode incertaine
- Version récente ou breaking change possible
- Feature sortie après ta date de connaissance

## Quand s'abstenir

Ne **pas** appeler si tu connais déjà la réponse de façon fiable (lib stable, API de base type Spring core, React hooks classiques) → réponds directement.
C'est l'abstention qui rend la recette économe : pas d'appel réflexe.

## Recette — 2 appels WebFetch

**Étape 1 — résoudre le `libraryId`**

```
GET https://context7.com/api/v2/libs/search?libraryName=<nom>&query=<besoin en langage naturel>
```

→ récupérer le `libraryId` (format `/owner/repo`, ex: `/vercel/next.js`).

**Étape 2 — récupérer la doc ciblée**

```
GET https://context7.com/api/v2/context?libraryId=<id>&query=<question précise>&type=json
```

→ tableau `{ title, content }`, filtré côté serveur (~3.3k tokens en moyenne depuis 2026).

## Paramètres

| Param | Rôle | Conseil |
|---|---|---|
| `libraryName` | nom de la lib (étape 1) | court, ex: `react`, `spring-boot` |
| `query` | question ciblée | une vraie question, pas le nom seul → moins de tokens |
| `libraryId` | ID résolu (étape 2) | format `/owner/repo` |
| `type` | format de sortie | `json` pour structuré, défaut = texte brut |

## Clé API

Optionnelle. Sans clé → fonctionne, rate limit bas. Avec clé → variable d'env `CONTEXT7_API_KEY` (header `Authorization: Bearer ctx7sk...`), **jamais en dur**.
À activer seulement si les rate limits gênent.

## Fallback en cascade

Si Context7 échoue ou rate-limit :
1. `llms.txt` officiel de la lib (ex: `https://<doc-officielle>/llms.txt`) via WebFetch
2. `WebSearch` + `WebFetch` sur la doc officielle

**No silent failure** : indiquer explicitement quelle source a servi (Context7 / llms.txt / web).

## Citation des sources

Toujours remonter les URLs renvoyées par la réponse — Context7 expose les sources. Traçabilité obligatoire.

## Garde-fou budget

- 1 query ciblée, pas de boucle d'exploration
- Max ~2 appels WebFetch
- Si insuffisant → demander une précision à l'utilisateur plutôt que multiplier les appels
