Source : https://leekwars.com/encyclopedia/fr/Bulbes

# Bulbes

Les bulbes sont les invocations de Leek Wars. Les poireaux peuvent invoquer des bulbes afin de les aider à infliger des dégâts, pour se soigner, se protéger, etc. Le premier bulbe que vous obtenez est le [Bulbe Chétif](https://leekwars.com/encyclopedia/fr/Bulbe_Ch%C3%A9tif) au [Niveau 48](https://leekwars.com/encyclopedia/fr/Niveau_48).

Dans le marché, les fiches des puces permettant d'invoquer un bulbe sont un peu différentes. En effet, elles présentent les caractéristiques du bulbe qui sera invoqué :

### Invocation

Si vous avez essayé d'utiliser votre bulbe avec [useChip](https://leekwars.com/help/documentation/useChip), vous avez peut-être été surpris de voir que celui-ci ne faisait rien. Leek Wars est un jeu de programmation. Vous codez l'IA de votre poireau, mais aussi de vos bulbes !

Il faudra d'abord créer une fonction qui fera office d'[IA](https://leekwars.com/encyclopedia/fr/IA) pour votre bulbe, par exemple :

function bulbAI() { var summoner = getSummoner() say("Bonjour, moi c'est Fab.") moveToward(summoner) useChip(CHIP_PROTEIN, summoner) }

Par exemple, avec cette fonction votre bulbe suivra votre poireau pour lui donner le boost de [Protéines](https://leekwars.com/encyclopedia/fr/Prot%C3%A9ines).

Dans la fonction, si vous utilisez [getEntity](https://leekwars.com/help/documentation/getEntity), vous obtiendrez bien l'identifiant du bulbe, et non de votre poireau. Les fonctions renvoyant des informations sur "votre poireau" renverront les informations du bulbe si elles sont dans une fonction qui sert d'[IA](https://leekwars.com/encyclopedia/fr/IA) à un bulbe.

Il faut ensuite trouver une cellule où invoquer votre bulbe :

var cell = getCellToUseChipOnCell(CHIP_PUNY_BULB, getCell())

Comment ça marche ? Si depuis cette cellule il est possible d'invoquer sur la cellule de votre poireau, alors par symétrie l'inverse est également possible.

Enfin, il faudra invoquer votre bulbe avec la fonction [summon](https://leekwars.com/help/documentation/summon). Par exemple :

summon(CHIP_PUNY_BULB, cell, bulbAI, "Fab")

Notez qu'il faut passer en paramètre le nom de la fonction qui servira d'IA au bulbe, mais sans les parenthèses.

**Attention** : Il est important de noter que la fonction que vous donnez a votre bulbe fait partie de votre IA. Cela signifie que vos bulbes partagent vos **variables globales et fonctions** (cool !) mais **également vos opérations** (pas cool). Prenez garde a ne pas dépasser vos opérations dans l'IA de vos invocations.

Il est possible d'avoir jusqu'à 8 bulbes invoqués en même temps dans une équipe, voir la constante [SUMMON_LIMIT](https://leekwars.com/encyclopedia/fr/SUMMON_LIMIT).

### Caractéristiques du Bulbe

Ses caractéristiques sont affichées sous la forme d'une plage de valeurs, par exemple "0 à 100 de [Force](https://leekwars.com/encyclopedia/fr/Force)". Cette valeur dépend du niveau du poireau qui invoque le bulbe. Un poireau de niveau 1 invoquera un bulbe avec les caractéristiques minimum. Et un poireau niveau 300 invoquera un bulbe avec les caractéristiques maximum.

Le rapport entre le niveau de l'invocateur et les caractéristiques est linéaire. C'est-à-dire que, pour "0 à 100 de [Force](https://leekwars.com/encyclopedia/fr/Force)", à chaque fois que le poireau montera de 3 niveaux, le bulbe gagnera 1 de Force. Par exemple, au niveau 100, le bulbe aura 33 de Force, au niveau 150, il en aura 50 et au niveau 200, il en aura 66.

Remarque : aucun bulbe n'étant débloqué au niveau 1, un bulbe n'aura jamais les statistiques les plus basses indiquées sur sa fiche.

Entre les deux niveaux, les caractéristiques sont calculées de manière linéaire, en suivant la formule suivante :

`caracteristique = floor(min + (max - min) * min(300, niveauInvocateur) / 300)`

Si le niveau de l'invocateur est 301, les caractéristiques sont celles d'un invocateur niveau 300.

Ainsi, un invocateur niveau 48 invoquera un Bulbe Chétif avec `50 + (300 - 50) * 48/300 = 50 + 250 * 0.16 = 90` de vie et `4 + (7 - 4) * 48/300 = 4 + 3 * 0.16 = 4.48` TP, arrondi vers le bas à 4 TP (floor).

Un Bulbe Chétif invoqué par un niveau 301 aura `50 + (300 - 50) * 300/300 = 50 + 250 * 1 = 300` de vie et `4 + (7 - 4) * 300/300 = 4 + 3 * 1 = 7` TP.

Les caractéristiques d'un bulbe sont également obtensibles en combat via la fonction [getBulbCharacteristics](https://leekwars.com/encyclopedia/fr/getBulbCharacteristics) (dépréciée) ou [getBulbStats](https://leekwars.com/encyclopedia/fr/getBulbStats).

### Équipement

Chaque bulbe possède 4 à 6 [Puces](https://leekwars.com/encyclopedia/fr/Puces) différentes que vous ne pouvez pas changer. Celles-ci varient en fonction du bulbe et sont identiques à celles utilisées par les poireaux. Vous pouvez de suite remarquer qu'un bulbe ne peut pas équiper d'[Armes](https://leekwars.com/encyclopedia/fr/Armes).

Le temps de récupération d'une puce d'invocation de bulbe est commun à tous les poireaux de l'équipe. Cela ne change rien en solo, mais en éleveur ou en équipe cela signifie qu'il est impossible d'invoquer deux bulbes du même type dans un tour.