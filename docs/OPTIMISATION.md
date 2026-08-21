Optimisation
Ici on va parler d'optimisation, l'objectif de l'optimisation est d'améliorer les performances d'un algorithme. En général quand on parle d'optimisation, on parle de temps d’exécution, le but étant de réduire le temps nécessaire pour l’exécution d'une série d'instruction.

En LeekScript, ce temps d'exécution est estimé par un nombre : le nombre d'opérations utilisées par ce calcul.
On va donc parler de certaines bonnes pratiques et bons réflexes pour optimiser un programme, quel que soit le langage, ainsi que certaines optimisations plus spécifiques au LeekScript, et intimement liées à la façon dont sont comptées les opérations.

Si ce n'est pas déjà fait, je vous invite à relire l'article du Tutoriel LeekScript : Opérations.

Menu : 
- Les bons réflexes
- Retirer des boucles ce qui ne va pas changer
- Les fonctions Leek Wars qui coûtent cher
Exemple :
- Réduire les coûts des appels aux fonctions de base
Mise en cache
Mémoïsation
- Se lancer dans le HASH
Utiliser des opérateurs binaires
Mémoïser les cases accessibles
Faire de la bouillie
- Sacrifier la lisibilité
remplacer floor
Faire une moyenne entière
Gratter les comparaisons
Les bons réflexes#
Ne pas optimiser avant d'avoir un code qui marche : En effet, il y a de grandes chances pour que le bout de code que l'on rédige ne soit appelé qu'une fois par tour, ce qui fait que le temps passé à optimiser le code n'aura aucun effet remarquable sur la consommation globale d'opérations.
Par exemple, une économie de 500 opérations sur une fonction appelée une seule fois n'économisera que 500 opérations. (logique)
En revanche, une économie d'une seule opération, sur une fonction qui est appelée dans une boucle de boucle de boucle peut réduire le coût en opérations de plusieurs dizaines de milliers d'opérations.
Ce qui m'amène au deuxième point :

repérer où ça coute cher !
La moitié du travail d'optimisation d'un code consiste simplement à chercher où partent les opérations (ensuite faut crier fort et leur dire de revenir). Qu'est ce qui coûte cher dans le code ?
Pour ça, pas de secret, on va mesurer !

Dans notre arsenal, le LeekScript fournit une fonction qui va se révéler très utile : getOperations.
Cette fonction permet de connaître le nombre d'opérations dépensées jusqu'à maintenant dans le code.

Exemple d'outil simple permettant de mesurer le coût d'une fonction :

global __debug_operation;
function startOp(){
	__debug_operation = getOperations();
}
function stopOp(title){
	var ops = getOperations()-__debug_operation - 3;
	debug("Operations (" + title + ") : " + ops);
}

startOp();
stopOp("test à vide"); // test à vide: 0

startOp();
say("hello world");
stopOp("hello world"); // hello world: 30
On peut ainsi confirmer que say coute bien 30 opérations, comme annoncé par la documentation.

Il est possible, et je vous recommande fortement de faire des outils permettant de mesurer d'autres choses dans votre IA, comme le nombre d'appels à une fonction, ainsi que son coût moyen par exemple, ce qui permettra de mieux mesurer l'évolution des coûts dans votre IA, et l'impact de certaines optimisations.

La page Complexité vous aidera à comprendre pourquoi un algorithme coûte cher et comment résoudre le problème. Pour résumer très simplement, on préferera éviter d'imbriquer des boucles entre elles dans la mesure du possible. On cherchera également à limiter la taille de nos boucles, par exemple en ne parcourant que nos cellules accessibles au lieu de parcourir toutes les cellules de la carte.
Il est important de noter qu'un algorithme qui a une complexité plus faible utilisera beaucoup moins d'opérations pour un nombre d'éléments à traiter assez grand, pensez-y avant d'essayer de gratter de petites optimisations !

Retirer des boucles ce qui ne va pas changer#
Imaginons le code suivant :

var TP = getTP();

// tirer autant de fois que possible sur l'ennemi !
for (var i = 0; i < floor(TP / getWeaponCost(getWeapon())); i++) {
	useWeapon(getNearestEnemy());
}
La fonction getNearestEnemy va être appelée à chaque itération de la boucle alors qu'elle renverra toujours le même résultat ! Pour éviter cela, il suffit de mettre le résultat dans une variable avant la fonction.
On fait la même chose pour 
floor(TP / getWeaponCost(getWeapon()))
 qui est aussi évalué à chaque itération.
Ce qui donne :

var TP = getTP();

// tirer autant de fois que possible sur l'ennemi !
var enemy = getNearestEnemy();
var nbShots = floor(TP / getWeaponCost(getWeapon())); // nombre de tirs possibles avec l'arme actuelle
for (var i = 0; i < nbShots; i++) {
	useWeapon(enemy);
}
Les fonctions Leek Wars qui coûtent cher#
inArray, il est pratique le inArray, il fait ce qu'on veut, mais il implique un coût important en opérations que l'on ne remarque pas forcément au premier coup d'oeil.
En effet, à l'intérieur, ça ressemble à ça :

function inArray(element, array){
  for (var value in array) 
  	if (value == element) 
		return true;
  return false;
}
Cet exemple est une bonne illustration pour parler un peu de complexité.
On voit ici que le coût réel de cette fonction dépend dans le pire cas de la taille du tableau array, que l'on va nommer n.
Cette fonction à donc une complexité n, c'est à dire qu'elle va nécessiter jusqu'à n opérations pour trouver le résultat.

Alors qu'en utilisant une table associative (Map), et en cherchant l'existence d'une clé, on peut s'assurer que la recherche ne coutera que le prix de l'accès à la case du tableau, soit 2 opérations.

if (mapContainsKey(map, key)) // la clé existe.
Donc, mon conseil ici, c'est qu'à chaque fois que vous utilisez la fonction inArray, il est probable qu'en ayant un tableau associatif avec ce que vous cherchez en clé vous permettrait d'économiser beaucoup d'opérations !
C'est d'autant plus vrai quand le inArray est dans une boucle de boucle...

⚠️ Attention : la création d'une table a un coût, si dans votre code inArray n'est appelé qu'une seule fois sur un tableau, il est probablement inutile de créer à partir de ce tableau une table associative pour mettre les valeurs en clé. Ça devient rapidement intéressant lorsque l'appel est dans une boucle. Depuis l'arrivée du Leekscript 4 les tables coûtent également plus cher en opérations que les tableaux.

Les fonctions getPath et getPathLength, utilisées à répétition, ont tendance à consommer des quantités monstrueuses d'opérations. Si vous utilisez régulièrement ces fonctions (dans une boucle), il est fort probable que des économies d'opérations soient possibles en utilisant une fonction de cellules accessibles qui renvoie les cases en clé et les distances en valeur, permettant après l'appel initial de réduire le cout d'un getPathLength à 2 opérations (le coût d'un accès à une case d'une table).

Exemple :#
var myCell = getCell();
var attackCell1 = getCellToUseXXX(enemy);
var attackCell2 = getCellToUseXXX(enemy);

// ici, pour savoir si les cases d'attaque sont atteignables, plutôt que de faire de multiples appel à getPathLength pour faire ce genre de test :
var distance = getPathLength(myCell, attackCell1);
if(distance != null /* cas d'un blocage */ && distance <= getMP()) // on est à distance pour attaquer.

// on va pouvoir avoir cette même information pour seulement 2 opérations ainsi :
var reachableCells = getReachableCells(myCell, getMP()); // fonction appelée une seule fois par tour
if(mapContainsKey(reachableCells, attackCell1)) // la case est atteignable, cout de l'opération : 2 opérations.
Ce genre d'optimisation n'a pas ou peu d'impact sur un nombre faible d'appel, mais prend tout son sens lorsque l'on fait des boucles de test, typiquement lorsqu'on teste différents combos jouables pour choisir la meilleure action.

Réduire les coûts des appels aux fonctions de base#
Attention, à partir de cette section les optimisations sont destinées à un public avancé et ne sont pas nécessaires pour faire fonctionner une IA de poireau dans les limites autorisées par le jeu. Essayez d'appliquer les conseils précédents, mesurez la consommation de votre code par section et optimisez la partie "algorithme" de votre code en limitant les calculs à des cases vraiment utiles pour vous sans recalculer plusieurs fois la même valeur pour une case donnée.
Si vous êtes débutant vous n'avez pas besoin de lire la suite de l'article.

Mise en cache#
Beaucoup de fonctions de base du jeu coutent 15 opérations (getWeaponMaxRange, getStrength, etc...)
Si vous faites de nombreux appels à ces fonctions, il peut être utile de stocker les résultats dans des variables globales :

global WEAPON_MAX_RANGE = [];
if(getTurn()==1) WEAPON_MAX_RANGE[WEAPON_PISTOL] = getWeaponMaxRange(WEAPON_PISTOL);
Ainsi on pourra avoir accès à l'information plus tard pour seulement 2 opérations (le cout d'un accès au tableau), au lieu de 15, et ce pendant les 64 tours !
Le coût de l'initialisation de la variable globale n'est payé qu'au premier tour, rendant l'opération forcément intéressante dès le tour 2, et d'autant plus intéressante que les appels à ce genre de fonction sont nombreux, et parfois au milieu de vos boucles.

Mémoïsation#
Au lieu de remplir notre tableau en avance, il est aussi possible de ne le remplir que lorsque nous rencontrons une nouvelle valeur à traiter.

Si nous reprenons l'exemple précédent, cela implique de d'abord vérifier la valeur contenue dans notre tableau avant de l'utiliser:

global WEAPON_MAX_RANGE = [];

var pistolMaxRange;

var weaponMaxRange = WEAPON_MAX_RANGE[WEAPON_PISTOL];
if (weaponMaxRange !== null) {
	pistolMaxRange = weaponMaxRange;
}
else {
	var newMaxRange = getWeaponMaxRange(WEAPON_PISTOL);
	WEAPON_MAX_RANGE[WEAPON_PISTOL] = newMaxRange;
	pistolMaxRange = newMaxRange;
}
Cela implique un peu plus de d'opérations que de la simple mise en cache lors de la récupération de résultats déjà connu. Mais on évite ainsi de tout calculer en avance, et éventuellement de calculer certaines choses qui ne nous serviront jamais.

Cependant, cela reste très lourd à utiliser en terme de code. Heureusement, nous pouvons automatiser ce genre de chose. Il nous suffit de créer une fonction qui prend en argument la fonction à mémoïser, le cache dans lequel mettre les résultats obtenus, et l'argument à passer à la fonction à mémoïser dans le cas où le résultat ne serait pas déjà présent en cache:

function applyMemo(f, mem, x) {
	var ret = mem[x];
	if (ret !== null) {
		return ret;
	}
	else {
		ret = f(x);
		mem[x] = ret;
		return ret;
	}
}
Dans le cas de 
getWeaponMaxRange(WEAPON_PISTOL)
, nous avons simplement à utiliser 
applyMemo
 de la sorte:

global WEAPON_MAX_RANGE = [];

var pistolMaxRange = applyMemo(getWeaponMaxRange, WEAPON_MAX_RANGE, WEAPON_PISTOL);
Il est possible de rendre cela encore plus simple d'utilisation, en définissant une fonction 
memoize
 qui prend en argument une fonction à mémoïser, et qui nous retourne une fonction mémoïsée. (Attention, plus nous rendons facile l'utilisation, plus nous consommons d'opérations. Il est toujours une bonne idée d’estimer quel méthode est préférable selon les besoins de performance et de facilité d'utilisation.)

function memoize(f) {
	var mem = [];

	return function(x) {
		return applyMemo(f, mem, x);
	};
}
Dans le cas de 
getWeaponMaxRange(WEAPON_PISTOL)
, nous avons simplement à utiliser 
memoize
 de la sorte:

global mWeaponMaxRange = memoize(getWeaponMaxRange);

var pistolMaxRange = mWeaponMaxRange(WEAPON_PISTOL);
Il est à noter que les implémentations fournies ici ne sont pas les plus optimisées qui puissent être. Au boulot.

Note : pour une notation plus concise, on peut utiliser le fait que l'assignation renvoie la valeur assignée :

function getValue(key) {
	return (key in cache) ? cache[key] : (cache[key] = calculerLaValeur(key));
}
Se lancer dans le HASH#
Très pratique la mémoisation n'est ce pas ?
Mais comment utiliser cette méthode pour stocker le résultat d'une fonction qui prend plus de paramètres ?

Le principe d'un hash est d'encoder une information sur une plus petite dimension. D'après wikipedia une fonction de hashage est une fonction particulière qui, à partir d'une donnée fournie en entrée, calcule une empreinte numérique servant à identifier rapidement la donnée initiale

Imaginons qu'on veuille stocker le résultat de la fonction 
lineOfSight
, qui prend 2 paramètres (la cellule de départ et la cellule d'arrivée), on peut simplement faire :
Petit rappel : Une cellule peut prendre une valeur de 0 a 612.

global SAVED_LOS = [];

function lineOfSight_MEMO(cell1, cell2) {
	var hash = cell1 * 1000 + cell2;
	if(SAVED_LOS[hash] === null) {
		//Pas encore mémoisée
		SAVED_LOS[hash] = lineOfSight(cell1, cell2);
	}
	return SAVED_LOS[hash];
}
Et voila, pas bien compliqué ! Le hash obtenu est un seul nombre qui contient les informations des deux cellules ! Pour cell1 = 13 et cell2 = 310, notre hash vaudra donc 13310;
Ici, la multiplication coûte 5 opérations, avec le if qui coûte 1 opération et les accès a 2 opérations, ça nous fait au minimum 11 opérations, sur les 30 que coute 
lineOfSight
.

Mais on peut mieux faire !

Utiliser des opérateurs binaires#
Oups j'en vois qui font les gros yeux. Rien de compliqué j'le jure !
Le LeekScript utilise des nombres codés sur 32 bits, c'est-à-dire qu'un nombre est stocké avec 32 0 ou 1.
Le but de cette méthode est d'utiliser un peu de cet espace pour mettre nos données.
Un exemple vaut 1000 mots, revenons sur la fonction lineOfSight :
On va commencer par chercher la puissance de 2 plus élevée que le nombre maximum qu'on cherche a stocker :

2^	0	1	2	3	4	5	6	7	8	9	10	11	...	31
Résultat	1	2	4	8	16	32	64	128	256	512	1024	2048		2147483648
Pour notre cellule qui a un maximum de 612, on va donc prendre 1024, c'est a dire 10 bits (2^10 = 1024).

Maintenant il nous suffit d'utiliser des opérateurs de décalage pour stocker tout ça. Il va vous falloir connaître l'utilisation d'au moins deux d'entre eux : 
|
 et 
<<
 (Un p'tit tour sur l'utilisation des opérateurs binaires pour se rafraîchir la mémoire).
On part sur une variable vide, égale a 0 par défaut :

var hash = cell1 << 10;	//On ajoute la cell1 décalée de 10 bits
hash = hash | cell2;	//On ajoute la cell2 au début
Si on simplifie ce code, ça nous donne 
var hash = cell1 << 10 | cell2;
, ce qui ne consomme que 3 opérations !
Pour cell1 = 13 et cell2 = 310, notre hash vaudra 13622.
Notre variable hash contient donc un nombre binaire, avec 10 bits réservés a cell1 et 10 bits pour cell2.

global SAVED_LOS = [];

function lineOfSight_MEMO(cell1, cell2) {
	var hash = cell1 << 10 | cell2;
	if(SAVED_LOS[hash] === null) {
		//Pas encore mémoisée
		SAVED_LOS[hash] = lineOfSight(cell1, cell2);
	}
	return SAVED_LOS[hash];
}
Notre fonction finale ne consomme plus que 7 opérations, une petite amélioration, non négligeable cependant.

La vrai force des hash binaire se révèle quand on veut stocker plus d'informations dedans :

Mémoïser les cases accessibles#
De quelles informations aurait on besoin pour mémoïser les cases accessibles ?
La position de départ, les points de mouvement (MP) disponibles et disons l'id du poireau (pourquoi pas !)

Pour commencer il faut définir combien de bits chaque élément pourra utiliser :

La cellule de départ est au maximum a 612, donc 10 bits
Les MP peuvent être en théorie de 0 a l'infini.. Comment on peut gèrer ça ?
Et bien il suffit de prendre un nombre suffisamment grand pour ne pas le dépasser ! Au hasard, quelque chose comme 20 MP. Il nous faudra donc 5 bits.
Pareil pour l'id du poireau. On va mettre un nombre assez haut, disons 50. On utilisera donc 6 bits.
var hash = cell << 11 | id << 5 | mp;
Quoi que quoi ?? Ils n'ont rien a voir avec le nombre de bits qu'on vient de décider là, si ?
Et bien si c'est très simple :

mp
 a besoin de 5 bits, donc on décale id de 5 bits pour laisser la place aux MP
id
 a besoin de 6 bits, et on doit donc décaler la cellule de 5 + 6 = 11 bits ! Logique.
Attention à bien vérifier que le nombre total de bits que vous utilisez ne dépasse pas les 64, sinon ils partiront dans le néant !
Ici on a 10 + 6 + 5 = 21 bits, on est large !

Pour ne pas se tromper, on peut utiliser une feuille de papier et noter notre méthode :

Donnée	cell	id	mp
Taille (bits)	10	6	5
Décalage	6 + 5 = 11	5 + 0 = 5	0
Essayez maintenant de stocker 2 cellules et une arme/puce ! Si vous y arrivez, vous maitrisez maintenant l'art du hash binaire.

Faire de la bouillie#
Comment gérer le cas où la taille de nos données à stocker dépasse les 64 bits ? Quand on a par exemple a un tableau de cellules, on ne pourra pas hasher tout ça avec notre intelligence binaire.

Heureusement un programmeur n'est jamais a court d'options : On va faire de la bouillie.
L'avantage de notre méthode binaire est qu'on peut récupérer les informations stockées si le besoin s'en fait sentir. Ici, on va abandonner tout espoir de récupération.

Pour un tableau, on peut utiliser une formule magique :

function array_hash(array) {
	if (not array)
		return 0;	//tableau vide ou null
	var result = 1;
	for (var element in array)	//pour chaque élément
		result = 63 * result + element;
	return result;
}
Le principe est simplement de modifier le hash en le multipliant par un nombre assez grand par rapport à 
element
.
Attention, cette fonction fonctionne (hum) mais l'unicité de son résultat est loin d'être garanti, il faut croire en notre bonne chance pour être sur que le résultat en sortie sera toujours différent si l'entrée est différente.
(Elle ne m'a jamais fait défaut)

A garder en tête quand on utilise cette fonction:

array
 doit être petit (< 15 éléments c'est cool, au dessus on prend des risques)
Faites attention a ce qui est mis dans 
element
, pour ne pas faire exploser la taille de votre hash et perdre des informations.
Sacrifier la lisibilité#
Parfois, il faut sacrifier la lisibilité du code pour améliorer ses performances.
Cette section est réservée aux méthodes bien crasseuses pour les gratteurs d'opérations, à vos risques et périls !
Il est recommandé de n'utiliser ces méthodes que dans des fonctions bas niveau qui sont appelées très souvent.

remplacer floor#
Le fonction 
floor
 renvoie l'arrondi bas d'un nombre. Par exemple 
floor(0.9) = 0
, 
floor(199.724) = 199
, ...
Il se trouve que les opérateurs binaires convertissent les nombres en entier pour seulement une opération !
En utilisant 
nombre | 0
, on transforme donc 
nombre
 en entier (arrondi bas par défaut), ce qui nous donne le même comportement que 
floor
 !

0.9 | 0 = 0
199.724 | 0 = 199
Ca ne coute qu'une opération, une opération de gagnée !

Faire une moyenne entière#
La moyenne de deux valeurs peut être calculée par

var moyenne = (value1 + value2) / 2;
Pour un total de 6 opérations. Make it 2 avec la syntaxe suivante:

var moyenne = (value1 + value2) >> 1;
On utilise l'opérateur binaire de décalage pour faire la division par deux.
Attention ! Le résultat sera équivalent a 
floor((value1 + value2) / 2)
 a cause de la conversion implicite.
(Merci a Kavaliov)

Gratter les comparaisons#
Les opérateurs 
==
 et 
!=
 coûtent 1 opération chacun, c'est une opération de trop !

On va exploiter ici les conversions en arrière plan, comme pour la simplification du if.
Il se trouve que 
if(null)
 et 
if(0)
 donnent tout deux 
false
, c'est-à-dire que la condition suivant ce if ne s'exécutera pas.
Si on est sûr que notre table ne contiendra pas de 0, de null ou de booléens, on peut simplement ne pas mettre le 
==
.

if (value != null) // 2 opérations
if	(value) // 1 opération
if (value == null) // 2 opérations
if	(!value) // 1 opération