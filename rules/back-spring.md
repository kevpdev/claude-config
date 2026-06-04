---
paths:
  - "**/*.java"
  - "**/pom.xml"
---

# Conventions back — Java / Spring Boot

## Documentation
- Toute classe et méthode **publique** → Javadoc complète : `@param`, `@return`, `@throws`.
- Pas de Javadoc qui paraphrase le nom (`/** Gets the name */`) — documenter le *pourquoi* / les invariants, pas l'évident.

## Tests
- JUnit 5 + Mockito. Un test = pattern **AAA** (Arrange / Act / Assert).
- Nom de méthode : `should_<effet>_when_<condition>` (ex. `should_throwNotFound_when_idUnknown`).
- Un assert logique par test ; mock uniquement les collaborateurs externes (pas le système sous test).

## Nommage
- Suffixe par rôle : `XxxController`, `XxxService`, `XxxRepository`, `XxxDto`.
- Un type public par fichier ; nom de fichier = nom du type.
- Packages en minuscules, par feature avant par couche si le module grossit.
