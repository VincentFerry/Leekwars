Source : https://leekwars.com/encyclopedia/fr/Tutoriel_sur_la_carte

# Tutoriel sur la carte

Tutoriel sur la carte ===================== > Règles du jeu

Vous aurez rapidement envie de parcourir la map de [Leek Wars](https://leekwars.com/encyclopedia/fr/Leek_Wars) par vos propres moyens. Mais pour cela, il faut comprendre comment elle fonctionne.

Peut-être vous semble-t-elle étrange, ou même complexe. Pourtant, elle est assez simple à utiliser, une fois que l'on a compris comment elle est disposée.

### Géometrie

![Tuto Map 1](/image/encyclopedia/TutoMap1.png)

La map du jeu est en vue isométrique. Ainsi, les cellules sont des carrés, et nous les voyons comme si nous étions placés au niveau d'un coin, un peu en hauteur.

![Tuto Map Iso](/image/encyclopedia/TutoMapIso.png)

Cet angle de vue fait penser que la map est rectangulaire. Mais si on la met "à plat", on obtient :

![Tuto Map à Plat](/image/encyclopedia/TutoMapAPlat.png)

La map est un carré incliné à 45° ou, plus visuellement, en forme de losange.

Si on la place dans un repère, la cellule au centre de la map se trouve aux coordonnées [0;0]. Les coins de la map sont aux coordonnées [0;-17], [0;17], [-17;0] et [17;0].

A cause de la forme de la map, on peut dire que  :

Avec x et y, les coordonnées d'une cellule et abs(), la fonction donnant la valeur absolue.

La somme des valeurs absolues des coordonnées d'une cellule ne peut pas dépasser 17. C'est-à-dire que, par exemple, les cellules de coordonnées [0;18], [9;12], [-12;10], etc. n'existent pas.

Dans [Leek Wars](https://leekwars.com/encyclopedia/fr/Leek_Wars), on peut travailler avec les coordonnées des cellules. Les fonctions [getCellX](https://leekwars.com/help/documentation/getCellX) et [getCellY](https://leekwars.com/help/documentation/getCellY) donnent respectivement les coordonnées en x et en y d'une cellule donnée. La fonction [getCellFromXY](https://leekwars.com/help/documentation/getCellFromXY) fait le chemin inverse et renvoie la cellule qui se trouve aux coordonnées passées en paramètre. Attention, si vous lui passez des coordonnées en dehors de la map, la fonction retournera **null**.

On peut aussi recalculer les coordonnées à partir de l'identifiant de la cellule en faisant :

![Tuto Map Axes](/image/encyclopedia/TutoMapAxes.png)

### Tester si deux cellules sont en diagonale

Pour savoir si deux cellulles sont en ligne, vous pouvez utiliser la fonction [isOnSameLine](https://leekwars.com/help/documentation/isOnSameLine). Pour les diagonales il faut utiliser la formule suivante, pour deux cellules de coordonnées (x1, y1) et (x2, y2) :

### Parcourir la carte

Enfin, vous aurez peut-être besoin de parcourir la totalité de la map. Mais la forme de la map la rend un peu plus complexe à parcourir avec les coordonnées.

Via les coordonnées, il faudrait par exemple faire ceci :

Mais la map comporte 613 cellules, numérotées de 0 à 612.

De ce fait, on peut parcourir les cellules d'une façon bien plus simple et moins coûteuse en opérations :

La forme de la map ainsi que l'ordre des cases permettent d'obtenir une propriété intéressante qui permet de déduire une cellule a partir de ses coordonnées : une cellule peut se retrouver grâce a la formule (`306 + 18 * x + 17 * y`). Ainsi, un décalage d'une unité sur l'axe des x se traduit par une variation de la valeur de la cellule de 18, et un décalage sur l'axe des y par une variation de la valeur de la cellule de 17. Cette propriété permet d'économiser un grand nombre d'opération dans un certain nombre d'algorithmes, mais cela nécessite de gérer les bordures gauche et droite de la map : en voulant se déplacer d'une case, on peut par erreur obtenir une case située à l'opposé de la map !

Lors de vos combats, vous avez la possibilité de visualiser les numéros des cellules : dans les options, il faut sélectionner les cases _Afficher numéros cases_ (pour voir les numéros) et _Mode tactique_ (pour cacher les obstacles).

### Numéros des cellules

La numérotation des cellules est la suivante :

### Contenu des cellules (obstacles, entités)

Vous pouvez consulter le contenu d'une cellule donnée grâce aux fonctions [getCellContent(cell)](https://leekwars.com/help/documentation/getCellContent), [isObstacle(cell)](https://leekwars.com/help/documentation/isObstacle), [isEntity(cell)](https://leekwars.com/help/documentation/isEntity) et [isEmptyCell(cell)](https://leekwars.com/help/documentation/isEmptyCell). Vous pouvez également trouver l'ensemble des obstacles du combat grâce à la fonction [getObstacles()](https://leekwars.com/help/documentation/getObstacles).