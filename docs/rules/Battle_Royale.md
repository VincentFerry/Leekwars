Source : https://leekwars.com/encyclopedia/fr/Battle_Royale

# Battle Royale

Les [Battle Royales](https://www.youtube.com/watch?v=O5x3-DGhTHw) sont un mode de jeu introduit dans la MàJ 1.92 et modifié par la MàJ 2.46. Elles sont basées sur des combats à 10 à 20 joueurs en mode 'chacun pour sa peau', il y a donc 10 à 20 équipes de 1 joueur sur le terrain, ouvrant ainsi de nouvelles possibilités aux IA.

On peut s'y inscrire dès le niveau 20, et les poireaux sont répartis en 4 paliers : niveau 20 à 99, 100 à 199, 200 à 299, et 300/301 (dans les BR automatiques) ou réunis tous ensembles (dans les BR potager). Il suffit de se rendre dans le potager sur l'onglet Battle Royale et de sélectionner un poireau. Vous entrez ainsi dans le salon correspondant à votre palier de niveau et voyez les autres poireaux en attente. Une fois qu'au moins 10 poireaux sont inscrits le combat commence, au bout de 20 secondes !

### Mécanisme de puissance

La puissance est une nouvelle caractéristique sur les entités qui intervient dans le calcul des dégâts (directs, poison, life_damage ou nova_damage) et qui agit comme un multiplicateur global de la valeur finale d'un dégât. On a donc la formule :

`dégâts = dégâts_item * (1 + force / 100) * (1 + puissance / 100)` (remplacer force par magie pour les poisons ou science pour les nova_damage) En résumé : 50 puissance = +50% dégâts, 100 puissance = +100% ou x2 dégâts

Les règles de gain de puissance en BR sont les suivantes :

À chaque fin de tour de jeu, toutes les entités vivantes (poireaux ou bulbes) gagnent 2 de puissance à l'infini. Chaque kill offre 10 puissance pour un poireau ou un coffre et 2 pour un bulbe + 50% de la puissance accumulée par la victime. Le bonus de kill du coffre selon son type vient s'ajouter en plus respectivement 10, 50 ou 100 selon que c'est un coffre en bois, fer ou diamant. De plus, cet effet de puissance est irréductible. Un effet irréductible ne peut pas être retiré par Libération. Il est indiqué par un modificateur [EFFECT_MODIFIER_IRREDUCTIBLE](https://leekwars.com/encyclopedia/fr/EFFECT_MODIFIER_IRREDUCTIBLE).

La fonction [getPower](https://leekwars.com/encyclopedia/fr/getPower) associée à ce mécanisme permet de récupérer la puissance actuelle d'une entité. À noter que l'effet de puissance de la BR est donné par un item fictif d'ID 0.

Autre point à surveiller en BR : si vous tuez quelqu'un avec châtiment, vous gagnez 10 puissance + la moitié de la puissance accumulée de la cible. Ce gain de puissance se situant à la fin du premier dégât, il est effectif pour le second dégât ! Attention donc de calculer le second dégât avec le gain potentiel de puissance lié au kill de votre cible.