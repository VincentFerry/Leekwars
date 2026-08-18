Source : https://leekwars.com/encyclopedia/fr/Lasers

# Lasers

Les lasers ont un type d'[AoE](https://leekwars.com/encyclopedia/fr/AoE) spécifique. Leur comportement est différent des aires d'effet classiques.

Les fonctions [getWeaponArea](https://leekwars.com/encyclopedia/fr/getWeaponArea) et [getChipArea](https://leekwars.com/encyclopedia/fr/getChipArea) renvoient la constante [AREA_LASER_LINE](https://leekwars.com/help/documentation/AREA_LASER_LINE) si l'arme ou la puce possède une aire d'effet de type laser.

Une arme ou une puce dite "laser" ne peut tirer qu'en ligne, il faut donc s'aligner avec la cible, à l'aide de [moveTowardLine](https://leekwars.com/encyclopedia/fr/moveTowardLine) et [isOnSameLine](https://leekwars.com/encyclopedia/fr/isOnSameLine).

### Comportement du laser

Le comportement du laser dépendra de la cellule visée et de la présence ou non d'obstacle dans la direction du tir.

#### Sans obstacles

Dans le cas d'un laser ayant une portée de 2 à 7 cellules, s'il n'y a pas d'obstacle et que vous visez la cellule se trouvant à 2 de distance de vous, la zone sera celle-ci :

![Laser line](https://i.imgur.com/joYB6lp.png)

Toutes les entités se trouvant dans la zone subiront les effets du laser. Les lasers ne sont pas soumis à la même réduction que les autres aires d'effet : chaque cellule subira 100% de l'effet.

Les cellules touchées seront celles qui sont à portée, dans l'exemple, toutes celles qui sont entre 2 et 7 de portée, 2 et 7 incluses. Si une entité ou un obstacle se trouve avant la première case de la zone d'effet (la case 1 sur l'exemple), il n'est pas possible de tirer.

La même zone de 2 à 7 sera affectée quelle que soit la case visée parmi les cases en rouge.

#### Avec obstacles

Les obstacles stoppent le laser. Ainsi un laser "continue sa route" jusqu'à ce qu'il atteigne sa portée maximale ou un obstacle.

Toujours avec une portée de 2 à 7, si la cellule à 2 de distance est visée et qu'un obstacle se trouve à 5 cellules de distance, alors la zone touchée sera celle-ci :

![Laser obst](https://i.imgur.com/juRC7ve.png)