Source : https://leekwars.com/encyclopedia/fr/Description_Avanc%C3%A9e_des_Combats

# Description avancée des combats

Ce document explique, étape par étape, le fonctionnement des combats dans *Leek Wars*, en décrivant la façon dont les attaques sont calculées et appliquées. Il aborde également les spécificités de chaque type de dégâts, ainsi que les mécaniques avancées (vol de vie, renvoi, érosion, coups critiques, etc.).

### Introduction aux types d’attaques

Dans *Leek Wars*, chaque attaque peut correspondre à l’un (ou plusieurs) des effets suivants :

- **Dégâts physiques** : [EFFECT_DAMAGE](https://leekwars.com/encyclopedia/fr/EFFECT_DAMAGE) (dégâts classiques) et [EFFECT_LIFE_DAMAGE](https://leekwars.com/encyclopedia/fr/EFFECT_LIFE_DAMAGE) (basés sur la vie de l’attaquant, via la puce [Châtiment](https://leekwars.com/encyclopedia/fr/Ch%C3%A2timent)).
- **Dégâts magiques (Poison)** : [EFFECT_POISON](https://leekwars.com/encyclopedia/fr/EFFECT_POISON) (ignorent l’armure et s’appliquent au début du tour de la cible).
- **Séquelles** : [EFFECT_AFTEREFFECT](https://leekwars.com/encyclopedia/fr/EFFECT_AFTEREFFECT) (fonctionnent comme le poison mais appliquent des dégâts immédiatement, puis à chaque tour du destinataire).
- **Dégâts nova** : [EFFECT_NOVA_DAMAGE](https://leekwars.com/encyclopedia/fr/EFFECT_NOVA_DAMAGE) (réduisent la vie maximale, ne fonctionnent que sur la partie “vie manquante” de la cible).
- Certains autres effets appliquent des calculs similaires, mais ne seront pas abordés sur cette page

Chaque type de dégât suit globalement la même logique de résolution, à quelques exceptions près (armure ignorée pour le poison, vol de vie non appliqué pour le LIFE_DAMAGE, etc.). Les paragraphes suivants décrivent en détail les étapes pour chaque type d’attaque.

### Déroulement d’une attaque

#### Tirage aléatoire des dégâts de base

Lorsqu’une arme ou une puce est utilisée, ses dégâts de base (indiqués dans la description via [getWeaponEffects](https://leekwars.com/encyclopedia/fr/getWeaponEffects) ou [getChipEffects](https://leekwars.com/encyclopedia/fr/getChipEffects)) sont tirés aléatoirement **une seule fois** dans la plage [min, max], en utilisant une loi uniforme.

> *Exemple :* > Pour l’arme [magnum](https://leekwars.com/encyclopedia/fr/magnum) dont la plage de dégâts est [25, 40], l’attaque va tirer une valeur aléatoire unique entre 25 et 40.

Si l’arme (ou la puce) possède plusieurs effets de dégâts, **la même valeur tirée est réutilisée pour chaque effet** (par exemple, les 3 impacts du [machine gun](https://leekwars.com/encyclopedia/fr/machine_gun) ont la même valeur de base). **Cependant**, toutes les étapes (force, armure, etc.) se répètent séparément pour chaque effet.

#### Prise en compte des statistiques : Force, Magie, Science, Puissance

> **Force** : Utilisée pour [EFFECT_DAMAGE](https://leekwars.com/encyclopedia/fr/EFFECT_DAMAGE) et [EFFECT_LIFE_DAMAGE](https://leekwars.com/encyclopedia/fr/EFFECT_LIFE_DAMAGE). > **Magie** : Utilisée pour [EFFECT_POISON](https://leekwars.com/encyclopedia/fr/EFFECT_POISON). > **Science** : Utilisée pour [EFFECT_NOVA_DAMAGE](https://leekwars.com/encyclopedia/fr/EFFECT_NOVA_DAMAGE).

Pour les attaques physiques et nova, la formule générale est :

avec `stat` = Force, Magie ou Science selon le type de dégâts.

Pour les dégâts de la puce [Châtiment](https://leekwars.com/encyclopedia/fr/Ch%C3%A2timent) ([EFFECT_LIFE_DAMAGE](https://leekwars.com/encyclopedia/fr/EFFECT_LIFE_DAMAGE)), c’est un cas particulier :

*(Ces dégâts n’octroient pas de vol de vie.)*

##### Puissance

En mode [Battle Royale](https://leekwars.com/encyclopedia/fr/Battle_Royale) (ou lorsqu’un coffre est éliminé), la statistique **Puissance** se cumule (via [getPower](https://leekwars.com/encyclopedia/fr/getPower)) et intervient également dans le calcul :

Elle fonctionne de manière similaire pour [EFFECT_LIFE_DAMAGE](https://leekwars.com/encyclopedia/fr/EFFECT_LIFE_DAMAGE) :

> *Remarque :* La fonction [getPower](https://leekwars.com/encyclopedia/fr/getPower) renvoie 0 en dehors du mode Battle Royale, donc un code générique suffit pour tous les modes de jeu.

#### Réduction lors de dégâts de zone (AoE)

Si l’arme ou la puce possède une zone d’effet (ex. le [lance-grenades](https://leekwars.com/encyclopedia/fr/lance-grenades)), les dégâts diminuent de 20% par case supplémentaire depuis le centre de l’explosion.

> *Exemple :* > Au centre, le [lance-grenades](https://leekwars.com/encyclopedia/fr/lance-grenades) inflige 100% de ses dégâts ([55,63] avec 0 de force). À une distance de 1 case, il inflige 80% ([44, 50]) ; à 2 cases, 60% ([33,37]), etc.

#### Armure et vulnérabilité

> *(Ignorez cette étape pour les attaques poison et nova.)*

##### Armure

L’armure se divise en deux catégories : **relative** (en %) et **absolue** (valeur brute). On l’applique après le calcul des dégâts totaux selon la formule :

- **Bouclier relatif** : réduit les dégâts d’un pourcentage donné.
- **Bouclier absolu** : soustrait une valeur fixe.

> *Exemple :* > Avec 20 d’armure relative et 15 d’armure absolue, sans prendre en compte la force, sur une attaque [75,120], la cible subit [45,81] de dégâts finaux.

> *Exemple 2 :* > Contre un [machine gun](https://leekwars.com/encyclopedia/fr/machine_gun) [10-15] x3 et 15 d’armure absolue, sans prendre en compte la force, chaque balle inflige au mieux 15 - 15 = 0 dégâts. La cible ne subira donc rien du tout.

**Remarque :** Si la cible a 100 d’armure relative, elle est immunisée aux dégâts (sauf si elle a de la vulnérabilité ou qu’une autre mécanique négative lui abaisse son armure).

##### Vulnérabilité

Deux types : **absolue** ([EFFECT_ABSOLUTE_VULNERABILITY](https://leekwars.com/encyclopedia/fr/EFFECT_ABSOLUTE_VULNERABILITY)) et **relative** ([EFFECT_VULNERABILITY](https://leekwars.com/encyclopedia/fr/EFFECT_VULNERABILITY)). Elles se soustraient respectivement à l’armure absolue ou relative de la cible, pouvant même la rendre négative (augmentant alors les dégâts subis).

> *Exemple :* > - Un fusil à pompe [33,43] frappe une cible avec 15 d’armure absolue : dégâts [18,28]. > - Dans la foulée, on applique -20 d’armure absolue (vulnérabilité). L’armure absolue de la cible passe à -5. > - Une seconde attaque [33,43] inflige alors [38,48] (car l’armure négative **augmente** les dégâts subis).

#### Application des dégâts

Selon le type d’attaque, les dégâts finaux (après force/magie/science, puissance, AoE, armures et vulnérabilités) sont alors appliqués à la cible.

- Si la cible tombe à 0 PV ou moins, elle est considérée comme éliminée.
- Pour certains effets (comme [EFFECT_AFTEREFFECT](https://leekwars.com/encyclopedia/fr/EFFECT_AFTEREFFECT)), un deuxième déclenchement survient au début du tour du destinataire.

#### Érosion

L’[Érosion](https://leekwars.com/encyclopedia/fr/%C3%89rosion) (*ou dégâts Nova*) diminue la **vie max** d’une entité lorsqu’elle subit des dégâts.

- **Dégâts physiques et directs** : la vie max baisse de 5% des dégâts subis.
- **Poison et séquelles** : la vie max baisse de 10% des dégâts subis.
- **Coup critique** : ajoute +10% d’érosion (cumulant 20% pour le poison spécifiquement ou 15% pour tout autre type de dégâts).
- **Renvoi de dégâts** : génère également de l’érosion (5% puisqu'il s’agit de dégâts physiques).

> *Exemples :* > - Perdre 100 PV en attaque directe = la vie max baisse de 5 PV. > - Perdre 100 PV en poison = la vie max baisse de 10 PV.

#### Vol de vie

> *(Uniquement pour [EFFECT_DAMAGE](https://leekwars.com/encyclopedia/fr/EFFECT_DAMAGE) — pas de vol de vie sur soi-même ni sur [EFFECT_LIFE_DAMAGE](https://leekwars.com/encyclopedia/fr/EFFECT_LIFE_DAMAGE), poison ou nova.)*

Après application de l’armure, l’attaquant peut regagner un pourcentage des dégâts infligés, proportionnel à sa **Sagesse** :

- On ne peut pas dépasser sa vie max.
- Si la cible est tuée, on ne récupère que sur les dégâts réellement infligés.
- Le vol de vie s’applique même en frappant un allié (contrairement à soi-même : [CHIP_DEVIL_STRIKE](https://leekwars.com/encyclopedia/fr/CHIP_DEVIL_STRIKE)).

#### Renvoi de dégâts

> *(Ignoré pour les attaques poison et nova.)*

Si la cible dispose de [renvoi de dégâts](https://leekwars.com/encyclopedia/fr/renvoi_de_d%C3%A9g%C3%A2ts) ([EFFECT_DAMAGE_RETURN](https://leekwars.com/encyclopedia/fr/EFFECT_DAMAGE_RETURN)), l’attaquant reçoit un pourcentage des dégâts infligés **avant** l’application de l’armure de la cible.

Ces dégâts ne tiennent pas compte de l’armure de l’attaquant et peuvent donc être supérieurs aux dégâts finaux si la cible a de la grosse armure ou un renvoi de dégâts > 100%.

#### Gains de puissance en cas d’élimination

En [Battle Royale](https://leekwars.com/encyclopedia/fr/Battle_Royale) ou lors de la destruction d’un coffre, tuer une entité octroie un bonus de **Puissance** (10 pour un poireau, 2 pour un bulbe, plus 50% de la puissance accumulée par la victime). Cela peut influer sur les dégâts des attaques suivantes *si* plusieurs effets sont enchaînés dans la même action.

### Détails et particularités par type de dégâts

#### Attaque physique (EFFECT_DAMAGE et EFFECT_LIFE_DAMAGE)

##### Ordre de résolution (pour chaque effet)

1. Tirage aléatoire des dégâts de base (une seule fois). 2. Effets passifs des [armes oubliées](https://leekwars.com/encyclopedia/fr/armes_oubli%C3%A9es) (attaquant). 3. Application des stats (Force/Puissance). 4. Réduction AoE (le cas échéant). 5. Armure (défenseur) + vulnérabilité éventuelle. 6. Application des dégâts (défenseur). 7. [Érosion](https://leekwars.com/encyclopedia/fr/%C3%89rosion) (défenseur). 8. Effets passifs des [armes oubliées](https://leekwars.com/encyclopedia/fr/armes_oubli%C3%A9es) (défenseur). 9. [Vol de vie](https://leekwars.com/encyclopedia/fr/Vol_de_vie) (attaquant). 10. [Renvoi de dégâts](https://leekwars.com/encyclopedia/fr/Renvoi_de_d%C3%A9g%C3%A2ts) (défenseur) et [Érosion](https://leekwars.com/encyclopedia/fr/%C3%89rosion) due au renvoi (attaquant). 11. Gain de puissance en cas d’élimination (en BR ou sur un coffre).

> **Remarques** : > - Pour [EFFECT_LIFE_DAMAGE](https://leekwars.com/encyclopedia/fr/EFFECT_LIFE_DAMAGE) (puce [Châtiment](https://leekwars.com/encyclopedia/fr/Ch%C3%A2timent)), les dégâts se basent sur la vie de l’attaquant, et il n’y a *pas* de vol de vie. > - Si l’attaquant et le défenseur sont la même entité (ex. auto-attaque), alors le vol de vie et le renvoi de dégâts ne s’appliquent pas.

#### Attaque magique (Poison – EFFECT_POISON)

Les poisons ignorent l’armure, le vol de vie et le renvoi de dégâts. L’ordre de résolution est :

1. Tirage aléatoire des dégâts de base (une seule fois). 2. Effets passifs des [armes oubliées](https://leekwars.com/encyclopedia/fr/armes_oubli%C3%A9es) (attaquant). 3. Application des stats (Magie/Puissance). 4. Réduction AoE (éventuelle).

Ensuite, **au début du tour de la cible** :

1. Application des dégâts (défenseur). 2. [Érosion](https://leekwars.com/encyclopedia/fr/%C3%89rosion) (défenseur). 3. Effets passifs des [armes oubliées](https://leekwars.com/encyclopedia/fr/armes_oubli%C3%A9es) (défenseur). 4. Gain de puissance en cas d’élimination.

> *Note* > Au début de chaque tour, les effets du poireau actif sont calculés, dans l'ordre retourné par [getEffects](https://leekwars.com/encyclopedia/fr/getEffects) cela veut dire que l'ordre des soins et des dégats de poisons importe car un poireau peut mourrir avant de se soigner ou vice-versa

#### Séquelles (EFFECT_AFTEREFFECT)

Similaires aux poisons, mais infligent également des dégâts **immédiats** lors de l’application :

1. Tirage aléatoire de la valeur de séquelles (dégâts) de base (une seule fois). 2. Effets passifs des [armes oubliées](https://leekwars.com/encyclopedia/fr/armes_oubli%C3%A9es) (lanceur). 3. Application des stats ([Science](https://leekwars.com/encyclopedia/fr/Science) du lanceur) + réduction AoE. 4. Application des dégâts (destinataire) + [Érosion](https://leekwars.com/encyclopedia/fr/%C3%89rosion). 5. Effets passifs des [armes oubliées](https://leekwars.com/encyclopedia/fr/armes_oubli%C3%A9es) (destinataire).

Ensuite, au début de chaque tour du destinataire :

1. Réapplication des dégâts (destinataire). 2. [Érosion](https://leekwars.com/encyclopedia/fr/%C3%89rosion) (destinataire). 3. Effets passifs des [armes oubliées](https://leekwars.com/encyclopedia/fr/armes_oubli%C3%A9es) (destinataire). 4. Gain de puissance en cas d’élimination (en BR ou sur un coffre).

Les séquelles ne peuvent pas être retirées avec la puce [Antidote](https://leekwars.com/encyclopedia/fr/Antidote).

#### Dégâts nova (EFFECT_NOVA_DAMAGE)

Les [dégâts nova](https://leekwars.com/encyclopedia/fr/d%C3%A9g%C3%A2ts_nova) visent la vie max de la cible, *jusqu’à la limite de sa vie manquante* :

1. Tirage aléatoire des dégâts nova de base (une seule fois). 2. Effets passifs des [armes oubliées](https://leekwars.com/encyclopedia/fr/armes_oubli%C3%A9es) (attaquant). 3. Application des stats ([Science](https://leekwars.com/encyclopedia/fr/Science)/Puissance). 4. Réduction AoE (éventuelle). 5. Application des dégâts nova (défenseur) (ignorent armure et renvoi, pas de vol de vie). 6. Effets passifs des [armes oubliées](https://leekwars.com/encyclopedia/fr/armes_oubli%C3%A9es) (défenseur).

### Interactions avancées

#### Coups critiques

Lorsqu’un [Coup critique](https://leekwars.com/encyclopedia/fr/Coup_critique) survient, un multiplicateur de **1,3** (constante [CRITICAL_FACTOR](https://leekwars.com/encyclopedia/fr/CRITICAL_FACTOR)) s’applique **dès le tirage aléatoire** des dégâts (étape 1). Tout l’effet de l’item (dégâts, etc.) est donc amplifié à hauteur de +30%. De plus :

- L’érosion est augmentée de 10% (cumulant 15% ou 20% pour le poison).
- Si c’est un bulbe qui est invoqué sur un critique, il gagne +20% en statistiques à la place. Son nom est affiché avec un point d'exclamation.
- Pour un effet de déplacement, le critique n’a pas d’effet particulier.

#### Passifs des armes oubliées

Les armes oubliées peuvent avoir des effets passifs (comme [EFFECT_DAMAGE_TO_ABSOLUTE_SHIELD](https://leekwars.com/encyclopedia/fr/EFFECT_DAMAGE_TO_ABSOLUTE_SHIELD), qui convertit un pourcentage de dégâts subis en bouclier absolu). Ces passifs :

- Se déclenchent **immédiatement** après que le poireau subisse des dégâts.
- Peuvent changer la donne *entre plusieurs impacts de la même attaque* (par exemple, on gagne du bouclier avant le deuxième impact d’un [machine gun](https://leekwars.com/encyclopedia/fr/machine_gun)).

Les effets passifs ont des noms de la forme `EFFECT_[événement]_TO_[caractéristique]`. Lorsque l'événement est détecté, un effet est appliqué sur l'entité portant l'arme oubliée. Cet effet est toujours du type `EFFECT_RAW_[caractéristique]`. Par exemple, il existe `EFFECT_MOVED_TO_MP` qui se déclenche lorsque l'entité subit un déplacement. Lorsque c'est le cas, elle se voit attribuer un effet `EFFECT_RAW_BUFF_MP`

### Conclusion

Chaque type d’effet (physique, poison, séquelles, nova) a ses particularités, avec des interactions spécifiques (armure, érosion, renvoi, vol de vie). Les points importants à retenir sont :

1. Les dégâts de base sont déterminés une seule fois (même pour les attaques multiples). 2. Les stats (Force, Magie, Science, Puissance) modifient ensuite ces dégâts. 3. L’armure (relative et absolue) intervient pour les attaques physiques, mais pas pour le poison ni les dégâts nova. 4. Les dégâts appliqués génèrent de l’érosion, réduisant la vie maximale des poireaux. 5. Des mécaniques supplémentaires (vol de vie, renvoi, coups critiques, passifs d’armes oubliées) peuvent aussi s’activer à chaque étape.

En comprenant le déroulement précis de chaque étape, vous serez mieux armés pour optimiser vos stratégies d’attaque et de défense en fonction de la situation. Bonne chance dans l’arène !