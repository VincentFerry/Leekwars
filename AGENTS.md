# Notes projet — Leek Wars IA

## Typage strict

- Le code LeekScript est compilé/analysé avec le typage strict.
- Ne jamais comparer directement un élément de `Map` avec `null` (`map[key] == null` ou `map[key] != null` génère une erreur Sarow).
- Toujours utiliser `mapContainsKey(map, key)` pour tester l'existence d'une clé dans une `Map`.
- Ne pas ajouter de vérifications `x == null` / `x != null` sur des variables dont le type exclut `null` (ex: `Item`, `Leek`). Elles coûtent des opérations et sont statiquement fausses.