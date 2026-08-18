Source : https://leekwars.com/encyclopedia/fr/D%C3%A9g%C3%A2ts_nova

# Dégâts nova

Les dégats nova ont été introduit dans la maj 2.09 avec l'[Électriseur mystérieux](https://leekwars.com/encyclopedia/fr/%C3%89lectriseur_myst%C3%A9rieux), puis dans la maj 2.11 avec la puce [Altération](https://leekwars.com/encyclopedia/fr/Alt%C3%A9ration) et enfin dans la maj 2.21 avec la puce [Désintégration](https://leekwars.com/encyclopedia/fr/D%C3%A9sint%C3%A9gration).

Le fonctionnement est similaire à de l'[Érosion](https://leekwars.com/encyclopedia/fr/%C3%89rosion) (les deux valeurs sont d'ailleurs confondues dans les rapports de combat). Seul les points de vie maximum de la cible sont affectés, dans la limite des points de vie actuels de la cible.

Exemple : La cible est à 950pv / 1000pv max, je lui inflige 100 de dégâts nova, elle va passer à 950pv / 950pv max (on ne peut pas descendre en dessous des pv actuels de la cible, c'est donc inutile si la cible est à 100% de pv).

Les dégâts nova sont amplifiés par la science. La formule pour calculer les dégats finaux est `Dégâts nova finaux = min(pv max - pv actuel, dégât nova de base * (1 + science / 100))`

Exemple de combat utilisant la puce altération : https://leekwars.com/report/33882252