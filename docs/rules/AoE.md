Source : https://leekwars.com/encyclopedia/fr/AoE

# AoE

Les dégâts de zone (Ou AOE, pour Area Of Effect) existent dans de nombreux jeux. Dans Leek Wars, ils n'apportent pas seulement un moyen d'affecter plusieurs adversaires. Ils offrent aussi un aspect intéressant à coder.

### Explications

Les fonctions [getWeaponArea](https://leekwars.com/help/documentation/getWeaponArea) et [getChipArea](https://leekwars.com/help/documentation/getChipArea) renvoient respectivement le type d'AOE d'une arme ou d'une puce.

Ces fonctions renvoient une constante pouvant être :

- [AREA_POINT](https://leekwars.com/help/documentation/AREA_POINT) dans le cas d'une arme/puce n'ayant pas d'AOE et ne touchant donc, qu'une seule cellule.
- [AREA_LASER_LINE](https://leekwars.com/help/documentation/AREA_LASER_LINE) dans le cas d'une arme/puce ayant une AOE de type "[Lasers](https://leekwars.com/encyclopedia/fr/Lasers)".
- [AREA_CIRCLE_1](https://leekwars.com/help/documentation/AREA_CIRCLE_1) dans le cas d'une arme/puce ayant une AOE de 1 de rayon. (5 cases touchées)
- [AREA_CIRCLE_2](https://leekwars.com/help/documentation/AREA_CIRCLE_2) dans le cas d'une arme/puce ayant une AOE de 2 de rayon. (13 cases touchées)
- [AREA_CIRCLE_3](https://leekwars.com/help/documentation/AREA_CIRCLE_3) dans le cas d'une arme/puce ayant une AOE de 3 de rayon. (25 cases touchées)
- [AREA_PLUS_1](https://leekwars.com/help/documentation/AREA_PLUS_1) dans le cas d'une arme/puce ayant une AOE en croix de 1 de rayon. (5 cases touchées identique a AREA_CIRCLE_1)
- [AREA_PLUS_2](https://leekwars.com/help/documentation/AREA_PLUS_2) dans le cas d'une arme/puce ayant une AOE en croix de 2 de rayon. (9 cases touchées)
- [AREA_PLUS_3](https://leekwars.com/help/documentation/AREA_PLUS_3) dans le cas d'une arme/puce ayant une AOE en croix de 3 de rayon. (13 cases touchées)
- [AREA_X_1](https://leekwars.com/help/documentation/AREA_X_1) dans le cas d'une arme/puce ayant une AOE en croix de 2 de rayon. (5 cases touchées)
- [AREA_X_2](https://leekwars.com/help/documentation/AREA_X_2) dans le cas d'une arme/puce ayant une AOE en croix de 4 de rayon. (9 cases touchées)
- [AREA_X_3](https://leekwars.com/help/documentation/AREA_X_3) dans le cas d'une arme/puce ayant une AOE en croix de 6 de rayon. (13 cases touchées)
- [AREA_SQUARE_1](https://leekwars.com/help/documentation/AREA_SQUARE_1) dans le cas d'une arme/puce ayant une AOE en carré de 3 de coté (9 cases touchées, la case centrale et 1 case de largeur autour).
- [AREA_SQUARE_2](https://leekwars.com/help/documentation/AREA_SQUARE_2) dans le cas d'une arme/puce ayant une AOE en carré de 5 de coté (25 cases touchées, la case centrale et 2 cases de largeur autour).
- [AREA_ALLIES](https://leekwars.com/help/documentation/AREA_ALLIEs) dans le cas d'une arme/puce touchant tous les alliés du lanceur, peu importe la distance
- [AREA_ENEMIES](https://leekwars.com/help/documentation/AREA_ENEMIES) dans le cas d'une arme/puce touchant tous les enemis du lanceur, peu importe la distance

Les AoE de 3 cellules de rayon sont actuellement les plus grandes du jeu. La zone touchée est conséquente. ![](https://imgur.com/8zk5LQa.png)

### Réduction des effets

La puissance de l'effet diminue avec la distance au centre de l'AoE\*.

Ainsi, la cellule visée, au centre, subit 100% de l'effet. Pour le reste des cellules, le calcul de la proportion de l'effet est linéaire. Le calculs du pourcentage se fait avec l'équation suivante :

pourcentage = max(0., 1. - 0.2 * getCellDistance(centre, cell))

En sachant que nous ne pouvons pas dépasser le rayon d'impact !

![AOE values](https://imgur.com/tvFpd8E.png)

\* Pour les [lasers](https://leekwars.com/encyclopedia/fr/lasers), il n'y a pas de réduction : toutes les cellules sont affectées avec 100% de l'effet.

### Au travers des obstacles

Les dégâts de zone traversent les obstacles (sauf les [lasers](https://leekwars.com/encyclopedia/fr/lasers)). Il est donc possible de toucher un poireau se trouvant derrière un obstacle en visant une cellule précise.

Il est possible de viser une cellule précise afin de profiter pleinement des possibilités des dégâts de zone. Il faut pour cela utiliser les fonctions [useWeaponOnCell](https://leekwars.com/help/documentation/useWeaponOnCell) et [useChipOnCell](https://leekwars.com/help/documentation/useChipOnCell). Ainsi, vous pourrez tirer sur la cellule juste à coté de votre adversaire pour lui infliger des dégâts même s'il se cache derrière un obstacle !

Il n'est par contre pas possible de tirer sur un obstacle. Seules les cellules sur lesquelles vous avez la vision sont atteignables.

Exemple : ![AOE obstacles](https://imgur.com/MFJkbNw.png)

En gris, les obstacles et en rouge, les cellules touchées par les dégâts de zone.

La cellule visée est la cellule se trouvant au centre de l'image.