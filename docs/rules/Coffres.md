Source : https://leekwars.com/encyclopedia/fr/Coffres

# Coffres

### Généralités

Les coffres sont des entités apparaissant de manière aléatoire lors des combats. Ils n'appartiennent à aucune équipe et leur destruction récompense leur tueur en [Ressources](https://leekwars.com/encyclopedia/fr/Ressources) et en [puissance](https://leekwars.com/encyclopedia/fr/Battle_Royale). Ils peuvent aussi bien aparaître dans le potager qu'en tournoi et même en BR. En revanche, il n'apparaitront pas en combat de test. Un coffre dispose d'un tour de jeu durant lequel il peut utiliser des puces. Il n'a pas de PM et ne peut pas se déplacer. Cependant, ce n'est pas une entité statique, il est donc sensible à l'[Inversion](https://leekwars.com/encyclopedia/fr/Inversion), le [Grappin](https://leekwars.com/encyclopedia/fr/Grappin) ou encore le [Gant de boxe](https://leekwars.com/encyclopedia/fr/Gant_de_boxe). Il existe trois types de coffres différents, chacun ayant ses propres caractéristiques.

Apparence Nom Points de vie Puces Chance d'apparition Valeur des Récompenses Récompense en puissance

Coffre en bois 2 000

1.75% 30 000 10

Coffre en fer 5 000

2.5% 300 000 50

Coffre en diamant 20 000

0.75% 3 500 000 100

Les coffres ont 1 chance sur 20 d'apparaître dans un combat. Il peut aussi y avoir plusieurs coffres dans le même combat !

### Statistiques

Type de coffre PV PT Force Sagesse Agilité Résistance

2000 20 500 200 200 0

5000 20 1000 500 200 500

20000 20 2000 1000 200 1000

### Comportement

Grâce à la pugnacité de notre cher Nytope, l'IA des coffres a pu être décryptée dans ce topic. En voici le résumé :

- Tant qu'il a 100% de ses points de vie, un coffre ne fera rien.
- Il commence par se soigner.
- S'il a moins de 75% de sa vie, il utilisera ses puces de bouclier à disposition. (Aucune pour le coffre en bois)
- Il attaque une entité au hasard à sa portée.

### Astuce

#### Seed

Vous pouvez réutiliser la seed d'un combat où un coffre est apparu en combat de défi (Pas en combat de test). Ainsi vous pourrez améliorer le comportement de vos poireaux face à ces curiosités !

Pour observer des coffres en action, voici des combats d'exemple :

Coffre en bois Coffre en fer Coffre en diamant

#### Code

C'est bien beau tout ça mais comment fait-on pour interagir avec eux dans le code?

C'est assez simple, vous avez besoin de 3 fonctions de base, disponible dans le LeekScript: `getAliveEnemies()`, `getType()` et `getName()`.

Voici un exemple de code: