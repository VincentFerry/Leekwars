Source : https://leekwars.com/encyclopedia/fr/Coup_critique

# Coup critique

Un coup critique est comme un coup standard avec un bonus sur le résultat de l'action. En fonction de l'[Agilité](https://leekwars.com/encyclopedia/fr/Agilit%C3%A9) de l'entité, la probabilité de faire un coup critique est donné par la formule :

`Probabilité de coup critique = Agilité du lanceur / 1000`

Exemples :

- **0 agilité** ou moins => 0% de chance de coup critique
- **100 agilité** => 10% de chance
- **500 agilité** => 50%
- **1000 agilité** ou plus => 100%

Le bonus donné à un coup critique est de **30%** soit 1,3 * l'effet de base (dans le code vous pouvez utiliser la constante CRITICAL_FACTOR pour vous affranchir des éventuels changements de ratio en fonction des mises à jours).

Tous les [effets](https://leekwars.com/encyclopedia/fr/effets) peuvent critiquer, mais certains ne changent rien au résultat, par exemple teleport, antidote, push, attract, invert, remove_shackle... en coup critique donneront le même résultat qu'en coup normal.

Si vous faites une invocation avec un coup critique toutes les caractéristiques de l'invocation sont boostées de 20%.

Pour les items à plusieurs effets le bonus est appliqué à tous les [effets](https://leekwars.com/encyclopedia/fr/effets).

Pour les dégats faits par un coup critique le taux d'[érosion](https://leekwars.com/encyclopedia/fr/%C3%A9rosion) est augmenté de 10%.

- Pour un effet POISON critique, le taux d'[érosion](https://leekwars.com/encyclopedia/fr/%C3%A9rosion) passe de 10% à 20% des dommages infligés.
- Pour tous les autres effets critiques, le taux d'[érosion](https://leekwars.com/encyclopedia/fr/%C3%A9rosion) passe donc de 5% à 15% des dommages infligés.