Source : https://leekwars.com/encyclopedia/fr/Talent

# Talent

Dans LeekWars, le talent est la mesure de vos performances vis-à-vis des autres joueurs. Il est représenté par cet icône :

On retrouve les mesures de talent suivantes :

- Talent solo (talent individuel propre à chaque poireau, impacté par le potager **solo**),
- Talent d'éleveur (talent propre à chaque éleveur, impacté par le potager **éleveur**),
- Talent d'équipe (talent propre à chaque composition d'équipe, impacté par le potager **équipe**).

### Effets du talent

Le talent a plusieurs effets directs sur le jeu :

#### Ajustement du potager

Vous ne rencontrerez dans votre potager que des adversaires de talent similaire. L'algorithme exact du potager n'est pas public, mais vous pouvez retenir que plus vous progressez, plus vos adversaires seront coriaces !

#### Récompenses

Plus votre talent **relatif** est important, plus vous obtenez d'[expérience](https://leekwars.com/encyclopedia/fr/exp%C3%A9rience), de [habs](https://leekwars.com/encyclopedia/fr/habs) et de [ressources](https://leekwars.com/encyclopedia/fr/ressources) à la fin des combats ! Ce talent relatif est calculé comme la différence entre votre talent et le [talent moyen](https://leekwars.com/talent) des poireaux ou éleveurs de même niveau. Une différence de +3 talent par rapport à la moyenne donne +1% de gains (additif : +300 talent donne +100% de gains). Avoir un talent relatif négatif (moins de talent que la moyenne) n'a pas d'impact négatif sur vos gains, ouf !

### Évolution du talent

Combattre un adversaire fera évoluer votre talent. Il s'agit d'une échelle ressemblant au principe de [Classement Elo (wikipedia)](https://fr.wikipedia.org/wiki/Classement_Elo) (*K* = 30\*).

En gros :

- Si deux adversaires de même talent s'affrontent :
- Le gagnant gagne **15** , et le perdant perd **15** .
- En cas de match nul, les talents ne changent pas.

La valeur **15** ici va varier selon la différence de talent entre les adversaires : battre un adversaire plus faible / perdre contre un adversaire plus fort fera peu évoluer le talent, alors que battre un adversaire plus fort / perdre contre un adversaire plus faible le fera beaucoup évoluer.

- Si deux adversaires de talent différent s'affrontent (**A* a un meilleur talent que *B**) :
- Si **A* gagne, il remporte entre 15 et 0 , décroissant selon la différence de talent entre A et B, et *B** en perd autant.
- Si **B* gagne, il remporte entre 15 et 30 , croissant selon la différence de talent entre A et B, et *A** en perd autant.
- En cas de match nul, **A* perd entre 0 et 15 , et *B** en gagne autant.

\* Ces échanges de talent sont lissés à très bas niveau : un combat entre deux poireaux de niveau 1 aura une incidence minime sur leur talent.