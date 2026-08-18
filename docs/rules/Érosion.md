Source : https://leekwars.com/encyclopedia/fr/%C3%89rosion

# Érosion

L'Érosion à été implémentée pour la MAJ 1.98, le 1 juin 2017.

Pour comprendre ce qu'est l'érosion et "comment marche-t-elle ?"

### Compréhension

L'Érosion est un effet bien à part dans Leek Wars, il découle du fait d'infliger des dégâts à un ennemi.

Il n'est pas directement visible à l'écran mais est bien présent dans le jeu.

Il se caractérise par une diminution des Points de [vie maximum](https://leekwars.com/encyclopedia/fr/Vie_Max).

### Fonctionnement

La [vie maximum](https://leekwars.com/encyclopedia/fr/Vie_Max) diminue lorsque l'entité reçoit des dégâts.

Dégâts classiques (EFFECT_DAMAGE, EFFECT_LIFE_DAMAGE, EFFECT_DAMAGE_RETURN et EFFECT_AFTEREFFECT)

L'érosion pour les dégâts classiques est calculée ainsi :

- 5% des dégâts subis sont retirés à la [Vie Maximum](https://leekwars.com/encyclopedia/fr/Vie_Max) (la constante [EROSION_DAMAGE](https://leekwars.com/encyclopedia/fr/EROSION_DAMAGE))
- 15% dans le cadre d'un [Coup critique](https://leekwars.com/encyclopedia/fr/Coup_critique) ([EROSION_DAMAGE](https://leekwars.com/encyclopedia/fr/EROSION_DAMAGE) + [EROSION_CRITICAL_BONUS](https://leekwars.com/encyclopedia/fr/EROSION_CRITICAL_BONUS))

Il faut savoir que le bouclier absolu ou relatif atténue l'effet (sauf pour les dégâts de type EFFECT_DAMAGE_RETURN et EFFECT_AFTEREFFECT qui ignorent les boucliers), puisque l'érosion est calculée sur les dégâts subis par le poireau.

Dégâts de [Poison](https://leekwars.com/encyclopedia/fr/Poison) (EFFECT_POISON) L'érosion pour les dégâts de poisons (liés à la [Magie](https://leekwars.com/encyclopedia/fr/Magie)) est calculée différement des 2 précédents :

- 10% des dégâts du poison sont retirés à la [Vie Maximum](https://leekwars.com/encyclopedia/fr/Vie_Max) (la constante [EROSION_POISON](https://leekwars.com/encyclopedia/fr/EROSION_POISON))
- 20% dans le cadre d'un [Coup critique](https://leekwars.com/encyclopedia/fr/Coup_critique) ([EROSION_POISON](https://leekwars.com/encyclopedia/fr/EROSION_POISON) + [EROSION_CRITICAL_BONUS](https://leekwars.com/encyclopedia/fr/EROSION_CRITICAL_BONUS))

Cela a pour effet de raccourcir un peu les combats et d'augmenter l'intérêt d'investir en [Points de Vie](https://leekwars.com/encyclopedia/fr/Points_de_Vie), améliorant aussi l'efficacité des poisons.

Par ailleurs, la puce [Blindage](https://leekwars.com/encyclopedia/fr/Blindage) et les autres [Puces](https://leekwars.com/encyclopedia/fr/Puces) permettant de gagner de la [Vie Max](https://leekwars.com/encyclopedia/fr/Vie_Max) voient leur utilité augmenter.

### Voir aussi

- [Dégâts nova](https://leekwars.com/encyclopedia/fr/D%C3%A9g%C3%A2ts_nova)
- [Vie Max](https://leekwars.com/encyclopedia/fr/Vie_Max)
- [Vie](https://leekwars.com/encyclopedia/fr/Vie)