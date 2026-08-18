Source : https://leekwars.com/encyclopedia/fr/Effets

# Effets

Un effet peut représenter deux choses : Un mécanisme du jeu ou l'application dudit mécanisme.

### Effets des armes et puces

Ils sont utilisés dans la description d'une [arme](https://leekwars.com/encyclopedia/fr/armes) ou d'une [puce](https://leekwars.com/encyclopedia/fr/puces). On peut les récupérer avec getWeaponEffects et getChipEffects respectivement. Les effets passifs des armes oubliées sont aussi récupérables dans le même format avec la fonction getWeaponPassiveEffects. Le résultat est une liste d'effets sous forme de tableau de tableaux. Chaque effet est constitué :

- d'un type représentant quelle action cet effet aura sur le jeu en indice 0
- du jet minimum de l'effet (0 si l'effet n'a pas d'application numérique) en indice 1
- du jet maximum de l'effet (0 si l'effet n'a pas d'application numérique) en indice 2
- du nombre de tours durant lequel l'effet reste actif en indice 3
- un masque binaire pour déterminer les cibles affectées par l'effet en indice 4
- un masque binaire pour déterminer les modificateurs de l'effet en indice 5

#### Type

Nom de la constante Valeur Action

EFFECT_DAMAGE 1 Retire des points de vie à une entité. Amplifié par le force. Interagit avec les boucliers, le vol de vie, et le retour de dégâts. Réduit le maximum de points de vie de 5% du montant retiré.

EFFECT_HEAL 2 Rend des points de vie à une entité, limité par le maximum de points de vie. Amplifié par la sagesse.

EFFECT_BUFF_STRENGTH 3 Procure de la force à une entité. Amplifié par la science.

EFFECT_AGILITY 4 Augmente l'agilité de la cible. -->

EFFECT_BUFF_AGILITY 4 Procure de l'agilité à une entité. Amplifié par la science.

EFFECT_RELATIVE_SHIELD 5 Procure un bouclier relatif, réduisant les PV retirés par les dégâts d'un montant relatif. Amplifié par la résistance.

EFFECT_ABSOLUTE_SHIELD 6 Procure du bouclier absolu, réduisant les PV retirés par les dégâts d'un montant fixe. Amplifié par la résistance.

EFFECT_BUFF_MP 7 Procure des points de mouvement à une entité. Amplifié par la science.

EFFECT_BUFF_TP 8 Procure des points d'action à une entité. Amplifié par la science.

EFFECT_DEBUFF 9 Réduit la valeur de tous les effets présents sur une entité d'un pourcentage.

EFFECT_TELEPORT 10 Change la position du lanceur.

EFFECT_INVERT 11 Échange la position du lanceur avec celle de l'entité cible.

EFFECT_BOOST_MAX_LIFE 12 Augmente les points de vie et le maximum de points de vie d'une entité. Amplifié par la sagesse.

EFFECT_POISON 13 Retire des points de vie à une entité. Amplifié par la magie. Réduit le maximum de points de vie de 10% du montant retiré.

EFFECT_SUMMON 14 Invoque un bulbe. Aucun effet si la limite d'invocation de l'équipe est atteinte.

EFFECT_RESURRECT 15 Ressuscite une entité (PV max = moitié du PV max avant résurrection, PV courant = quart du PV max avant résurrection).

EFFECT_KILL 16 Retire tous les points de vie d'une entité.

EFFECT_SHACKLE_MP 17 Retire des points de mouvement à une entité. Amplifié par la magie.

EFFECT_SHACKLE_TP 18 Retire des points d'action à une entité. Amplifié par la magie.

EFFECT_SHACKLE_STRENGTH 19 Retire de la force à une entité. Amplifié par la magie.

EFFECT_DAMAGE_RETURN 20 Procure du renvoi de dégâts à une entité, retirant des PV aux entités infligeant des dégâts au bénéficiaire. Amplifié par l'agilité. Réduit le maximum de PV de 5% du montant retiré.

EFFECT_BUFF_RESISTANCE 21 Procure de la résistance à une entité. Amplifié par la science.

EFFECT_BUFF_WISDOM 22 Procure de la sagesse à une entité. Amplifié par la science.

EFFECT_ANTIDOTE 23 Retire tous les poisons (EFFECT_POISON) présents sur une cible.

EFFECT_SHACKLE_MAGIC 24 Retire de la magie à une entité. Amplifié par la magie.

EFFECT_AFTEREFFECT 25 Retire des points de vie à une entité. Amplifié par la science. Réduit le maximum de PV de 5% du montant retiré.

EFFECT_VULNERABILITY 26 Retire du bouclier relatif à une entité. N'est pas amplifié. Augmente les PV retirés par les dégâts d'un montant relatif.

EFFECT_ABSOLUTE_VULNERABILITY 27 Retire du bouclier absolu à une entité. N'est pas amplifié. Augmente les PV retirés par les dégâts d'un montant absolu.

EFFECT_LIFE_DAMAGE 28 Retire des PV selon un pourcentage de la vie du lanceur. Interagit avec les boucliers et le retour de dégâts. Réduit le maximum de PV de 5% du montant retiré.

EFFECT_STEAL_ABSOLUTE_SHIELD 29 Retire du bouclier absolu (EFFECT_ABSOLUTE_SHIELD) à la cible et le restitue au lanceur.

EFFECT_NOVA_DAMAGE 30 Retire des points de vie max. Amplifié par la science.

EFFECT_RAW_BUFF_MP 31 Procure des points de mouvement à une entité. Non amplifiable.

EFFECT_RAW_BUFF_TP 32 Procure des points d'action à une entité. Non amplifiable.

EFFECT_POISON_TO_SCIENCE 33 Procure de la science en fonction des dégâts poison (EFFECT_POISON) reçus.

EFFECT_DAMAGE_TO_ABSOLUTE_SHIELD 34 Procure du bouclier absolu (EFFECT_ABSOLUTE_SHIELD) en fonction des dégâts reçus (EFFECT_DAMAGE).

EFFECT_DAMAGE_TO_STRENGTH 35 Procure de la force en fonction des dégâts reçus (EFFECT_DAMAGE).

EFFECT_NOVA_DAMAGE_TO_MAGIC 36 Procure de la magie en fonction des dégâts Nova (EFFECT_NOVA_DAMAGE) reçus.

EFFECT_RAW_ABSOLUTE_SHIELD 37 Procure du bouclier absolu, réduisant les PV retirés par les dégâts (EFFECT_DAMAGE) d'un montant fixe. Non amplifiable.

EFFECT_RAW_BUFF_STRENGTH 38 Procure de la force à une entité. Non amplifiable.

EFFECT_RAW_BUFF_MAGIC 39 Procure de la magie à une entité. Non amplifiable.

EFFECT_RAW_BUFF_SCIENCE 40 Procure de la science à une entité. Non amplifiable.

EFFECT_RAW_BUFF_AGILITY 41 Procure de l'agilité à une entité. Non amplifiable.

EFFECT_RAW_BUFF_RESISTANCE 42 Procure de la résistance à une entité. Non amplifiable.

EFFECT_PROPAGATION 43 Se propage aux entités voisines de la cible à la fin de son tour.

EFFECT_RAW_BUFF_WISDOM 44 Procure de la sagesse à une entité. Non amplifiable.

EFFECT_NOVA_VITALITY 45 Augmente la vie max de la cible. Amplifié par la science.

EFFECT_ATTRACT 46 Attire la première entité en ligne sur la case cible.

EFFECT_SHACKLE_AGILITY 47 Retire de l'agilité à une entité. Amplifié par la magie.

EFFECT_SHACKLE_WISDOM 48 Retire de la sagesse à une entité. Amplifié par la magie.

EFFECT_REMOVE_SHACKLES 49 Retire toutes les entraves (EFFECT_SHACKLE_*) de la cible.

EFFECT_MOVED_TO_MP 50 Augmente les PM de l'entité cible pour chaque déplacement subit.

EFFECT_PUSH 51 Pousse la première entité de la ligne sur la case cible.

EFFECT_RAW_BUFF_POWER 52 Procure de la power à une entité. Non amplifié. Effet inutilisé.

EFFECT_REPEL 53 Éloigne l'entité cible d'un nombre de cases donné en ligne droite.

EFFECT_RAW_RELATIVE_SHIELD 54 Procure un bouclier relatif, réduisant les PV retirés par les dégâts (EFFECT_DAMAGE) d'un montant relatif. Non amplifié par la résistance.

EFFECT_ALLY_KILLED_TO_AGILITY 55 Donne de l'agilité à la cible pour chaque allié mort.

EFFECT_KILL_TO_TP 56 Augmente les PT de la cible pour chaque mort qu'elle cause.

EFFECT_RAW_HEAL 57 Rend des points de vie à une entité, limité par le maximum de PV. Non amplifié par la sagesse.

EFFECT_CRITICAL_TO_HEAL 58 Soigne pour chaque coup critique effectué par l'entité cible.

EFFECT_ADD_STATE 59 Ajoute un [état](https://leekwars.com/encyclopedia/fr/%C3%89tats) à l'entité cible.

EFFECT_TOTAL_DEBUFF 60 Retire 100% (130% en cas de Coup Critique) des effets de la cible.

EFFECT_STEAL_LIFE 61 Retire une certaine quantité de vie max à la cible et la restitue au lanceur.

EFFECT_MULTIPLY_STATS 62 Multiplie les stats de la cible par la valeur de l'effet. Pas de constante associée.

EFFECT_DAMAGE_TO_RESISTANCE 63 Procure de la résistance en fonction des dégâts reçus (EFFECT_DAMAGE).

#### Valeur min et max

Tous les effets indiquent une valeur minimale et maximale. La valeur finale sera tirée au hasard entre le minimum et le maximum.

Si vous voulez être sûrs de ne pas sous estimer la valeur de l'effet, utilisez le min. Si vous vous sentez chanceux, visez le max. Vous êtes indécis ? Une moyenne entre le min et le max saura vous satisfaire.

A vous de décider quel valeur vous pensez avoir !

La formule suivante vous permet de choisir un coefficient de confiance : si il est a 0, `valeur_finale` sera égal a `effect_min`, si il est a 1, `valeur_finale` sera égal a `effect_max`. ici il est a `0.5` pour obtenir la moyenne.

N'oubliez pas que la valeur de l'effet peut être multipliée par 1.3 en cas de [Coup critique](https://leekwars.com/encyclopedia/fr/Coup_critique) !

#### Durée

Il s'agit du nombre de tours pendant lesquels l'effet sera actif sur la cible.

Dans le cas des effets ponctuels (soins, poisons, dégâts), une valeur de 0 signifie que l'effet aura lieu au moment où l'effet est lancé, et une valeur non nulle (1 ou plus) le fera agir au début du tour de la cible.

#### Entités affectées

Les entités affectées par un effet sont encodées de manière binaire : si le bit correspondant a une catégorie d'entité vaut 1, cette catégorie sera affectée par l'effet.

Tester si une entité est vulnérable se fait alors en utilisant l'opérateur bit à bit ET (de symbole &), permettant ici de vérifier l'état d'un unique bit du nombre donné (les opérateurs == et === ne peuvent pas être utilisés : plusieurs bits peuvent être actifs simultanément).

Effet Valeur (binaire) Valeur (numérique) Entités affectées

EFFECT_TARGET_ENEMIES 00001 1 ennemis de l'entité qui applique l'effet

EFFECT_TARGET_ALLIES 00010 2 entités alliées de celle qui applique l'effet

EFFECT_TARGET_CASTER 00100 4 entité qui applique l'effet

EFFECT_TARGET_NON_SUMMONS 01000 8 poireaux, coffres, tourelles et mobds (qui ne sont pas des bulbes)

EFFECT_TARGET_SUMMONS 10000 16 bulbes

Par exemple, si le nombre représentant les entités affectées est 14 (en binaire : 01110), cela signifie que les entités affectées par l'effet sont les poireaux alliés, ainsi que celui qui applique l'effet. Donc, les bulbes et les ennemis ne seront pas affectés.

Le code suivant permet de tester si un effet affecte les bulbes ennemis :

#### Modificateurs

Comme les entités affectées, les modificateurs sont encodés de manière binaire. ces modificateurs s'appliquent sur l'effet pour en modifier la cible ou la valeur.

EFFECT_MODIFIER_STACKABLE 00001 1 L'effet est cumulable

EFFECT_MODIFIER_MULTIPLIED_BY_TARGETS 00010 2 L'effet est multiplié par le nombre de cibles touchées dans la zone

EFFECT_MODIFIER_ON_CASTER 00100 4 Affecte toujours le lanceur.

EFFECT_MODIFIER_NOT_REPLACEABLE 01000 8 Non remplaçable.

EFFECT_MODIFIER_IRREDUCTIBLE 10000 16 Irréductible.

Le modificateur `EFFECT_MODIFIER_STACKABLE` permet d'indiquer que cet effet est cumulable, c'est a dit qu'une entité peut avoir plusieurs effets de ce type appliqués par la même arme ou puce. Par exemple, une entité peut avoir plusieurs effets de poison lancés par la même puce, mais ne peut pas avoir deux effets de boucliers absolus par la puce [Casque](https://leekwars.com/encyclopedia/fr/Casque). Si vous essayez de relancer [Casque](https://leekwars.com/encyclopedia/fr/Casque) sur un poireau qui a déjà l'effet de [Casque](https://leekwars.com/encyclopedia/fr/Casque), l'effet original sera remplacé par le nouveau. Attention a ne pas perdre de la protection en utilisant [Casque](https://leekwars.com/encyclopedia/fr/Casque) avec votre bulbe chétif sur un poireau déjà équipé par un meilleur [Casque](https://leekwars.com/encyclopedia/fr/Casque) !

Le modificateur `EFFECT_MODIFIER_MULTIPLIED_BY_TARGETS` multiplie la valeur de base de l'effet par le nombre d'entités dans l'[AoE](https://leekwars.com/encyclopedia/fr/AoE) de l'objet.

Le modificateur `EFFECT_MODIFIER_ON_CASTER` indique que cet effet s'appliquera toujours au lanceur. Il est présent par exemple sur l'effet du boost de force du [Glaive](https://leekwars.com/encyclopedia/fr/Glaive), ce qui permet de taper dans le vide pour gagner de la force.

Le modificateur `EFFECT_MODIFIER_NOT_REPLACEABLE` indique que cet effet ne sera pas remplacé si la cible le possède déjà (ex : lancer la [Covid-19](https://leekwars.com/encyclopedia/fr/Covid-19) sur un poireau étant déjà infecté ne changera pas la valeur du poison subit à cause la Covid).

Le modificateur `EFFECT_MODIFIER_IRREDUCTIBLE` indique que la valeur de cet effet ne peut pas être réduite (par exemple avec libération).

### Effets appliqués sur les entités

Ils servent à rendre compte de l'état détaillé d'une Entité. On peut les récupérer avec [getEffects](/help/documentation/getEffects). Le résultat est une liste d'effets sous forme de tableau de tableaux. Il est aussi possible de récupérer la liste des effets appliqués par une entité avec [getLaunchedEffects](/help/documentation/getLaunchedEffects), cela peut par exemple servir à décider de l'éliminer dans le cas où elle serait une figure importante de l'adversaire. Chaque effet est constitué des informations suivantes:

- le type représentant quelle action cet effet a sur l'entité, en indice 0,
- la valeur de l'effet, en indice 1,
- l'identifiant de l'entité qui a appliqué l'effet, en indice 2,
- le nombre de tours (mis à jour au tour du lanceur) restant avant que l'effet ne disparaisse, en indice 3,
- si l'effet à été appliqué avec un coup critique, en indice 4,
- l'identifiant de l'équipement qui a servi à appliquer l'effet, en indice 5,
- l'identifiant de l'entité sur laquelle l'effet a été appliqué, en indice 6.

Contrairement a l'effet obtenu par getWeaponEffects ou getChipEffects, vous avez ici un effet qui a déjà été lancé et dont la valeur est connue, pas d'estimation a faire cette fois.

Note: une entité ne peut pas cumuler plusieurs fois le même effet venant de la même arme ou puce,  sauf s'il est explicitement cumulable. Imaginons par exemple que vous ayez lancé [Armure](https://leekwars.com/encyclopedia/fr/Armure) sur vous, si votre Bulbe Métallique lance la même puce [Armure](https://leekwars.com/encyclopedia/fr/Armure) sur vous, elles ne s'additionneront pas. En revanche, le compteur de temps sera réinitialisé.

### Déroulement des effets

Au début du tour de chaque entité, dans l'ordre:

- Les effets `EFFECT_HEAL`, `EFFECT_AFTEREFFECT` et `EFFECT_POISON` sur l'entité sont appliqués, dans l'ordre reçu. Si l'entité tombe à <= 0 PVs à n'importe quel moment, elle meurt.
- Les effets ayant étés lancés par cette entité perdent 1 tour de durée. Si la durée d'un effet atteint 0, l'effet disparaît et tous les bonus/malus associés sont enlevés de la cible.
- L'IA de l'entité s'execute.

Ce que cela signifie:

- Une entité ayant un `EFFECT_POISON` sur elle lors de votre tour ne prendra pas nécessairement de dégâts, par exemple si il ne reste qu'un tour sur l'effet et que le lanceur de l'effet joue avant la victime.
- Si lors de l'execution de votre IA, il ne vous reste qu'un tour sur un boost lancé par vous même, ce boost n'aura aucun effet sur votre prochain tour. Cependant, si il ne vous reste qu'un tour sur un `EFFECT_HEAL` ou `EFFECT_POISON` lancé par vous même, celui ci aura un effet lors de votre prochain tour.