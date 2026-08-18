Source : https://leekwars.com/encyclopedia/fr/JavaScript%20et%20TypeScript

# JavaScript et TypeScript

&nbsp;

Depuis la version 2.49, en plus du [LeekScript](https://leekwars.com/encyclopedia/fr/LeekScript), vous pouvez écrire les [intelligences artificielles](https://leekwars.com/encyclopedia/fr/intelligence_artificielle) de vos poireaux en **JavaScript**, en **TypeScript** ou en [Python](https://leekwars.com/encyclopedia/fr/Python). Les IA s'exécutent dans un environnement sécurisé et déterministe, avec accès à toute l'API de combat du jeu, et peuvent affronter des IA écrites dans n'importe quel autre langage.

- **JavaScript** : ECMAScript 2026 (moteur GraalJS)
- **TypeScript** : TypeScript 5.8, transpilé en JavaScript au moment du combat

Débutant ? Suivez le tutoriel JavaScript / TypeScript pour apprendre à coder votre première IA, pas à pas.

### Choisir le langage

Le langage d'une IA est déterminé par l'**extension** de son fichier :

| Langage | Extension | |---------|-----------| | [LeekScript](https://leekwars.com/encyclopedia/fr/LeekScript) | *(aucune)* | | **JavaScript** | `.js` ou `.mjs` | | **TypeScript** | `.ts` ou `.mts` | | [Python](https://leekwars.com/encyclopedia/fr/Python) | `.py` |

Le langage se choisit à la création d'un fichier (bouton « Nouvelle IA » de l'éditeur) ou comme langage par défaut de la première IA à l'inscription. Renommer un fichier en changeant son extension change son langage.

### Point d'entrée : turn()

À chaque tour, le moteur exécute votre IA. Deux façons d'écrire :

**IA simple** : écrivez directement votre code, il est rejoué à chaque tour (dans une portée fraîche, sans état conservé) :

**IA avec état** : définissez une fonction `turn()`. Le corps du fichier n'est évalué qu'une seule fois (déclarez-y vos classes et variables persistantes), puis `turn()` est rejouée à chaque tour :

En **TypeScript ou JavaScript**, si votre fichier contient un `import` ou un `export`, il devient un *module* : une fonction `turn()` déclarée normalement y reste privée au module et n'est pas trouvée par le moteur. Déclarez-la alors avec `export function turn()` :

### L'API de combat

L'API du jeu est exposée sous forme **orientée objet**. Il n'y a pas de variable globale `me` : votre entité s'obtient via `Fight.me`.

Contrairement au LeekScript, il n'y a ni fonctions globales ni constantes « plates » (`getNearestEnemy()`, `WEAPON_PISTOL`…) : toute l'API passe par les objets ci-dessous.

#### Arborescence des classes

Les entités renvoyées par l'API sont typées : `enemy instanceof Leek`, `enemy instanceof Bulb`…

| Classe | Membres principaux | |--------|--------------------| | `Entity` | `life`, `maxLife`, `tp`, `mp`, `strength`, `agility`, `wisdom`, `resistance`, `science`, `magic`, `level`, `name`, `cell`, `weapon`, `weapons`, `chips`, `effects`, `states`, `summons`, `alive`, `dead`, `isAlly()`, `isEnemy()`, `distance(cible)` | | `Me` | tout `Entity`, plus les actions : `moveToward(cible)`, `moveAwayFrom(cible)`, `useWeapon(cible)`, `useChip(puce, cible)`, `setWeapon(arme)`, `say(message)`, `summon(puce, case, ia)`, `canUseWeapon(cible)`, `weaponCell(cible)`, `chipCells(puce, cible)`, `weaponTargets(case)`… | | `Cell` | `x`, `y`, `empty`, `obstacle`, `entity`, `distance(cible)`, `pathLength(cible)`, `lineOfSight(cible)`, `path(cible)` | | `Weapon` / `Chip` | `cost`, `minRange`, `maxRange`, `area`, `launchType`, `maxUses`, `needsLos`, `features` (plus `cooldown` et `currentCooldown` pour `Chip`) | | `Effect` | `type`, `value`, `caster`, `turns`, `critical`, `item`, `target` | | `Feature` | `type`, `minValue`, `maxValue`, `turns`, `targets` |

À côté des classes, quatre **singletons** :

| Singleton | Rôle | Membres principaux | |-----------|------|--------------------| | `Fight` | le combat | `me`, `turn`, `getNearestEnemy()`, `getFarthestEnemy()`, `getEnemies()`, `getAliveEnemies()`, `getAllies()`, `getAlliedTurret()`… | | `Field` | le terrain | `cellFromXY(x, y)`, `getObstacles()`, `distance(a, b)`, `pathLength(a, b)`, `lineOfSight(a, b)`, `path(a, b)` | | `Registers` | stockage persistant entre les combats | `get(clé)`, `set(clé, valeur)`, `delete(clé)`, `all()` | | `Debug` | visualisation sur le terrain | `mark(cases, couleur)`, `markText(cases, texte)`, `show(case)`, `clearMarks()`, `pause()` |

#### Les constantes

Les constantes sont rangées par famille, sous deux formes :

- **Instances** (armes et puces) : en camelCase, comparables par référence : `Weapon.pistol`, `Chip.bandage`, `me.weapon === Weapon.pistol`.
- **Catégories** : en MAJUSCULES : `Effect.DAMAGE`, `State.UNHEALABLE`, `Entity.Stat.STRENGTH`, `Entity.Type.LEEK`, `Cell.Type.EMPTY`, `Item.Area.CIRCLE_1`, `Item.LaunchType.LINE`, `Fight.Type.SOLO`, `Fight.Context.GARDEN`, `Field.NEXUS`…

L'autocomplétion de l'éditeur (`Weapon.`, `Effect.`, `Entity.Stat.`…) liste tous les membres disponibles.

### Plusieurs fichiers

Découpez votre IA en **modules ES** (`import` / `export`) :

Seuls vos propres fichiers sont accessibles : aucun accès au disque, au réseau ni au système.

### TypeScript

En `.ts`, l'éditeur vérifie vos types en direct : toute l'API de combat est typée (classes, méthodes, constantes), avec l'autocomplétion complète. Au moment du combat, le TypeScript est transpilé en JavaScript par le compilateur officiel `tsc`, puis exécuté par le même moteur. Une erreur de type rend l'IA invalide, comme une erreur de compilation en LeekScript.

### Environnement d'exécution

- **Combats reproductibles** : `Math.random()` est initialisé par la graine du combat et l'horloge (`Date.now()`, `performance.now()`) est figée, pour que les combats soient rejouables à l'identique.
- **console.log()** est redirigé vers le journal de combat, comme `debug()` en LeekScript : sa sortie apparaît dans le rapport.
- **Budget d'exécution** : comme en LeekScript, chaque tour dispose d'un budget d'opérations et de mémoire selon le niveau du poireau, calibré pour être comparable entre les langages. Dépasser le budget interrompt le tour.

### Voir aussi

- [LeekScript](https://leekwars.com/encyclopedia/fr/LeekScript) : le langage historique de Leek Wars
- [Python](https://leekwars.com/encyclopedia/fr/Python) : écrire son IA en Python
- Tutoriel JavaScript / TypeScript : apprendre à coder son IA pas à pas
- Documentation des fonctions et constantes