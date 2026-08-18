# Plan de refonte de l'IA Leek Wars

> Document de conception. Aucune ligne de code de production n'est encore écrite.
> Objectif : découpler évaluation / assemblage / ordonnancement, comparer de vrais
> combos, intégrer les déplacements aux combos (AOE), centraliser le scoring, et
> tenir le budget de **20 000 000 opérations/tour**.

---

## 1. Diagnostic synthétique (rappel)

| # | Problème | Localisation actuelle | Cause structurelle |
|---|----------|----------------------|--------------------|
| 1 | Ordre des actions non optimisé | `Action.sortActions`, `Combo.sortCombo` | Tri par `getCellDistance` (pas par chemin) ; ordre mélangé à la sélection |
| 2 | Sac à dos glouton au lieu de comparer des combos | `Combo.getComboFromActions` | Glouton qui mute l'état ; combos alternatifs hardcodés seulement |
| 3 | Évaluation + assemblage simultanés | `Action` constructeur → `getPriority()` ; `Leek.updateActions` re-score | Générer = scorer ; re-scoring en boucle pendant l'assemblage |
| 4 | Déplacements non intégrés (jump/grapin/push) | `CHIP_JUMP` exclu dès `getActions` ; bricolage dans `useAction`/`updateActions` ; `calcPrioPush` mute `cellTo` | Déplacement traité hors du modèle d'action |
| 5 | Config scoring non maintenable | Constantes + nombres magiques dispersés dans `Scoring` et `Action.getPriority` | Pas de source unique ; formule de dégâts dupliquée ; effet de bord `CHIP_PLASMA` |
| 6 | Logs d'optimisation absents | `Operations` désactivé (`debugOpe=false`) | Pas de budget par phase, pas d'adaptation au budget restant |

---

## 2. Architecture cible : pipeline à responsabilités séparées

```
                      main()
                        |
   +--------------------+--------------------+
   |  Cache (perception, inchangé/nettoyé)   |
   +--------------------+--------------------+
                        |
        (1) ActionGenerator  -> Array<Action> candidates (SANS score)
                        |
        (2) BoardState + DamageModel  -> apply(action)->delta ; value(state)
                        |
        (3) Planner (beam search borné par TP/MP + budget d'opé)
                        |  -> meilleur Plan (set d'actions comparé par valeur d'état)
                        |
        (4) Sequencer  -> ordre optimal (dépendances + chemin réel, une seule fois)
                        |
        (5) Executor   -> exécute le Plan résolu (zéro scoring)
```

Principe clé : **on ne mute plus `Cache.leeks` pendant la réflexion**. On simule sur
un `BoardState` léger avec `apply`/`undo`, ce qui rend la comparaison de combos possible
et supprime le re-scoring en boucle.

---

## 3. Modules, fichiers et signatures

### 3.1 `ScoringConfig` (nouveau fichier `ScoringConfig`)

But : source unique de tous les poids. Fin des nombres magiques dans le code métier.

```leekscript
class ScoringConfig {
    // Poids de base (repris des constantes actuelles de Scoring)
    static real W_RELATIVE_SHIELD   = 6.0;
    static real W_ABSOLUTE_SHIELD   = 0.8;
    static real W_VULNERABILITY     = 2.0;
    static real W_HEAL              = 1.0;
    static real W_NOVA              = 0.5;
    static real W_GENERIC_STATS     = 0.2;
    static real W_STRENGTH          = 0.4;
    static real W_RESISTANCE        = 0.7;
    static real W_MAGIC             = 0.6;
    static real W_TP                = 120.0;
    static real W_MP                = 60.0;   // aujourd'hui hardcodé dans getPrioShackleMp
    static real W_DAMAGE_RETURN     = 1.0;

    // Poids "sens tactique" (déplacements / AOE / ordre)
    static real W_AOE_EXTRA_TARGET  = 1.0;    // bonus par cible supplémentaire touchée
    static real W_PUSH_INTO_CLUSTER = 50.0;   // pousser un ennemi vers un groupe
    static real W_SURVIVAL          = 1.0;    // pénalité de danger de la cellule finale

    // Surcharges par type de combat
    static Map<integer, Map<string, real>> overrides = [
        FIGHT_TYPE_FARMER : [ ... ],
        FIGHT_TYPE_BATTLE_ROYALE : [ ... ],
    ];

    // Multiplicateurs contextuels tour 1 (aujourd'hui hardcodés dans Action.getPriority)
    static Map<integer, real> turn1Multipliers = [
        CHIP_REFLEXES: 1000.0, CHIP_WARM_UP: 1000.0, CHIP_PRISM: 75.0,
        CHIP_KNOWLEDGE: 50.0, CHIP_SOLIDIFICATION: 50.0, CHIP_RAGE: 5.0,
    ];

    static real get(string key) { ... }        // avec fallback + override fightType
}
```

Migration : chaque littéral numérique de `Scoring` et de `Action.getPriority`
est remplacé par un `ScoringConfig.get(...)`. Aucune valeur n'est perdue (on reprend
les valeurs actuelles à l'identique pour garantir la non-régression, puis on tune).

---

### 3.2 `DamageModel` (nouveau fichier `DamageModel`)

But : **une seule** implémentation des formules de combat, réutilisée par le scoring
et par la simulation. Supprime la duplication `getPrioDamage` / `getPrioLifeDamage`.

Formules ancrées sur `docs/GAME_RULES.md` (crit, érosion, boucliers, vol de vie) :

```leekscript
class DamageModel {
    // probabilité de critique en fonction de l'agilité
    static real critProb(integer agility) {
        return agility >= 1000 ? 1.0 : (agility >= 100 ? (agility - 100) / 900.0 : 0.0);
    }
    static real critFactor(real p) { return 1.0 + p * (CRITICAL_FACTOR - 1.0); }

    // dégâts effectifs après boucliers (relatif puis absolu)
    static real applyShields(real raw, real relShield, real absShield) {
        real v = raw * (1 - relShield / 100.0) - absShield;
        return v < 0 ? 0.0 : v;
    }

    // érosion : 5% des dégâts subis, +10% si critique certain (interpolé)
    static real erosion(real dealt, real p) { return dealt * (0.05 + p * 0.10); }

    // vol de vie plafonné par la vie manquante du lanceur
    static real lifeSteal(real dealt, integer wisdom, real missingLife) { ... }

    // renvoi de dégâts
    static real damageReturn(real rawBeforeShield, real drPercent) { ... }

    // point d'entrée unifié : renvoie {dealt, erosion, steal, returned}
    static Object resolveDamage(effect, casterState, targetState, real areaMulti) { ... }
}
```

`getPrioDamage`, `getPrioLifeDamage`, `getPrioNovaDamage` appellent tous
`DamageModel.resolveDamage`, puis appliquent seulement la logique de signe
ally/enemy + poids issus de `ScoringConfig`.

---

### 3.3 `BoardState` (nouveau fichier `BoardState`)

But : snapshot simulable *léger* (pas de `clone(Cache.leeks)` complet). On ne stocke
que ce qui change en cours de tour.

```leekscript
class BoardState {
    // état par entité : uniquement les champs mutables pendant le tour
    Map<integer, integer> cell;          // position simulée
    Map<integer, real>    life;
    Map<integer, real>    relShield;
    Map<integer, real>    absShield;
    Map<integer, real>    tp;
    Map<integer, integer> mp;
    Map<integer, Map>     usedItem;       // maxUse / cooldown simulés
    integer selfId;

    static BoardState fromCache();        // init depuis Cache.leeks (copie plate ciblée)

    // applique une action, renvoie un token d'undo (deltas) -> O(taille de l'aire)
    Object apply(Action a);
    void   undo(Object token);

    // helpers de lecture rapides
    integer entityOn(integer cell);
    boolean isReachable(integer fromCell, integer toCell, integer mp); // via Cache pré-calc
}
```

Points d'attention opérations :
- `apply`/`undo` par **deltas** (pas de clone). Coût borné par la taille de l'aire d'effet.
- `entityOn` : indexer `cell -> entityId` dans une Map, pas de boucle sur toutes les entités
  (corrige `Carte.getEntityOnCell` qui boucle actuellement).

---

### 3.4 `Action` (refonte)

But : **structure de données passive**. Plus de scoring dans le constructeur.
Une action décrit une transformation candidate, y compris les déplacements.

```leekscript
class Action {
    Item item;
    integer cellFrom;     // d'où on lance (après déplacement)
    integer cellTo;       // cible
    integer kind;         // ACT_ATTACK | ACT_BUFF | ACT_MOVE_JUMP | ACT_MOVE_GRAPPLE
                          //  | ACT_MOVE_PUSH | ACT_INVERSION | ACT_SUMMON | ACT_RES
    integer entityTarget; // -1 si aucun / cible principale
    // PAS de priority ici. Le score est calculé par l'Evaluator à la demande.
}
```

Le saut, le grapin, le gant, l'inversion deviennent des **actions de première classe**
avec un `kind` de déplacement et une transformation de plateau connue de `BoardState.apply`.

---

### 3.5 `ActionGenerator` (extrait de l'actuel `Leek.getActions`)

But : produire des candidats **sans score**, avec filtres structurels uniquement.

```leekscript
class ActionGenerator {
    // candidats d'attaque/buff : boucle cellsFrom x cellsTarget filtrée (range, LoS, launchType)
    static Array<Action> attacks(BoardState s, integer leekId);

    // candidats de déplacement offensif intégrés au combo :
    //  - jump vers une cellule qui débloque une AOE / une portée
    //  - grapin/gant : pousser/attirer une cible pour l'aligner ou la mettre en cluster
    //  - inversion : échanger positions pour setup
    static Array<Action> moves(BoardState s, integer leekId);
}
```

Optimisations pour tenir le budget :
- Pré-filtrer les cellules cibles par cible réelle (déjà partiellement fait via `Cache.cellsTargets*`).
- Générer les déplacements **seulement** vers des cellules "utiles" : cellules qui changent
  le nombre de cibles atteignables (indexation via `Cache.areaCell*` déjà en cache).
- Plafond dur + tri structurel léger (voir §5 budget), pas de tri par score ici.

---

### 3.6 `Evaluator` (remplace la dispersion `Scoring.*` appelée depuis `Action`)

But : fonction **pure** `state -> valeur`. Sépare "valeur d'un état" de "priorité d'une action".

```leekscript
class Evaluator {
    // valeur globale d'un état de plateau (plus haut = mieux pour nous)
    static real evaluateState(BoardState s) {
        // somme pondérée : dégâts infligés, kills, survie (danger cellule finale),
        // buffs alliés, contrôle (shackle), placement (AOE potentiel), ressources restantes
    }

    // gain marginal d'une action = value(apply(a)) - value(courant)  [via apply/undo]
    static real marginalGain(BoardState s, Action a);
}
```

Avantage : un combo n'est plus jugé "tue / ne tue pas" mais par
`evaluateState(état final)`, ce qui permet de comparer 90% vs 100% de dégâts,
setups AOE, contrôle, etc.

---

### 3.7 `Planner` (remplace `Combo.getComboFromActions` + `getCombos` + `evaluateCombos`)

But : rechercher la **meilleure séquence** sous contraintes TP/MP, en comparant des combos.

Algo : **beam search** (largeur adaptative).

```
frontier = [ état initial ]
pour profondeur = 1..maxDepth (borné par TP):
    next = []
    pour chaque noeud n de frontier:
        pour chaque action a applicable dans n.state (TP/MP ok, maxUse ok):
            child = n + a         // apply delta
            child.score = Evaluator.evaluateState(child.state)
            push(next, child)
        undo
    next = topK(next, beamWidth)  // beamWidth dépend du budget d'opé restant
    frontier = next
    if budget épuisé: break (log + garder le meilleur courant)
retourner meilleur noeud (set d'actions, non ordonné)
```

Points clés :
- Les déplacements (jump/push/grapin/inversion) sont des actions comme les autres →
  les setups AOE émergent de la recherche (ex. push ennemi dans un cluster puis AOE).
- Élagage : dominance (même TP/MP restants + score inférieur → jeté), et bornes
  supérieures optimistes pour couper des branches.
- Aucune mutation de `Cache` ; tout passe par `BoardState.apply/undo`.

---

### 3.8 `Sequencer` (remplace `Combo.sortCombo` / `Action.sortActions` côté ordre)

But : ordonner le *set* retenu **une seule fois**, après la recherche.

Règles d'ordre :
1. Contraintes dures d'abord : `CHIP_LIBERATION` en premier, buffs sur soi avant usage,
   inversion/grapin/gant (reposition) avant les AOE qui en dépendent, boucliers avant
   d'encaisser, `CHIP_ADRENALINE` avant les attaques coûteuses.
2. Minimisation du coût de déplacement réel : ordonner les `cellFrom` par **chemin**
   (`getPathLength`) et non par distance à vol d'oiseau — calculé une seule fois sur
   ~N actions retenues (petit N), donc abordable (corrige le "jumps pourris").
3. Résolution des sauts nécessaires en fonction de l'ordre final (le saut est déjà une
   action native, ici on ne fait que placer/insérer correctement).

---

### 3.9 `Executor` (nettoyage de `Action.useAction`)

But : **exécuter** un plan déjà résolu. Zéro scoring, zéro régénération d'actions,
zéro `getActions` en cours d'exécution.

- Supprimer les "hotfix dégeu" et branches `USE_INVALID_POSITION` mortes.
- Le déplacement + saut sont explicites dans le plan (plus de décision ici).
- Garder uniquement : setWeapon si besoin, useWeaponOnCell / useChipOnCell / summon / resurrect.
- Filet de sécurité TP restant en fin de tour : un mini-Planner à budget réduit (déjà
  présent dans `main` lignes "additionnal actions", à réécrire proprement).

---

### 3.10 `OpBudget` (remplace `Operations`)

But : budgétisation et **logs d'optimisation toujours actifs mais peu coûteux**.

```leekscript
class OpBudget {
    static integer LIMIT = getMaxOperations();          // 20M
    static Map<string, integer> phaseStart = [:];
    static Map<string, integer> phaseCost  = [:];

    static void begin(string phase);
    static void end(string phase);                       // enregistre le coût
    static boolean canContinue(real reserveRatio);       // ex. garder 15% pour l'exécution
    static integer beamWidthForRemaining();              // largeur adaptative
    static void report();                                // 1 debug structuré en fin de tour
}
```

Logs demandés (point 6) :
- Coût par phase (génération / éval / recherche / ordre / exécution).
- Raison d'arrêt de la recherche (profondeur atteinte vs budget épuisé vs frontier vide).
- Alertes : explosion de candidats (troncature), combo tronqué, TP gaspillé en fin de tour.

---

## 4. Ordre de migration (sans casser l'existant)

Chaque étape est indépendante et testable via `ScoringTest` / `benchmark`.

1. **`OpBudget`** : introduire d'abord la mesure (remplace `Operations`), activer les logs.
   Permet de mesurer les gains des étapes suivantes.
2. **`ScoringConfig`** : extraire toutes les constantes/nombres magiques. Aucune régression
   (valeurs identiques). Corrige au passage l'effet de bord `CHIP_PLASMA` (calcul local).
3. **`DamageModel`** : factoriser les formules de dégâts, brancher `Scoring.*` dessus.
4. **`BoardState`** + refonte de `Action` en structure passive + `Evaluator` : introduire
   la simulation par deltas. `Combo` continue de tourner via un adaptateur temporaire.
5. **`ActionGenerator`** : sortir `getActions` de `Leek`, ajouter les déplacements en
   actions natives (jump/push/grapin/inversion).
6. **`Planner`** (beam search) : remplacer `getComboFromActions`/`getCombos`/`evaluateCombos`.
   Bascule derrière un flag pour comparer A/B contre l'ancien glouton.
7. **`Sequencer`** : ordre par chemin réel + dépendances.
8. **`Executor`** : nettoyer `Action.useAction`, supprimer le code mort.
9. Retirer l'ancien `Combo` et les combos hardcodés une fois l'A/B validé.

---

## 5. Budget d'opérations cible (sur 20 000 000)

| Phase | Cible max | Levier principal |
|-------|-----------|------------------|
| Perception `Cache` | ~2.5M | Déjà en cache ; indexer `cell->entity` |
| `ActionGenerator` | ~4M | Filtres structurels + cibles utiles seulement ; plafond candidats |
| `Planner` (beam) | ~9M | `beamWidth` adaptatif via `OpBudget.beamWidthForRemaining()`, élagage par dominance |
| `Sequencer` | ~1M | `getPathLength` sur N petit (actions retenues) |
| `Executor` + filet | ~1.5M | Aucun scoring |
| Réserve de sécurité | ~2M | `canContinue(0.15)` stoppe la recherche avant dépassement |

Règle d'or : la recherche s'arrête **proprement** (garde le meilleur combo courant) dès
que `OpBudget.canContinue` passe faux, et le logue. On ne dépasse jamais la limite ;
on dégrade la qualité (largeur/profondeur) au lieu de crasher le tour.

---

## 6. Ce que la refonte règle, point par point

- **(1) Ordre** → isolé dans `Sequencer`, par chemin réel, calculé une seule fois.
- **(2) Sac à dos** → remplacé par un beam search qui compare des combos entiers.
- **(3) Éval/assemblage simultanés** → `Action` passive + `Evaluator` pur + `BoardState`
  simulé ; plus de re-scoring en boucle ni de mutation de `Cache` pendant la réflexion.
- **(4) Déplacements** → jump/push/grapin/inversion en actions natives dans la recherche →
  setups AOE émergents.
- **(5) Config scoring** → `ScoringConfig` (source unique) + `DamageModel` (formules
  uniques), effet de bord `CHIP_PLASMA` supprimé.
- **(6) Logs** → `OpBudget` toujours actif, coûts par phase + raisons d'arrêt + alertes.

---

## 7. Risques & points de vigilance

- **Budget d'opé du beam search** : le risque #1. Mitigé par largeur adaptative + élagage +
  garde `canContinue`. À valider par un prototype mesuré (BoardState+DamageModel+Planner
  sur un cas réel) avant généralisation.
- **Coût de `BoardState`** : impératif d'éviter tout `clone` global ; deltas + index.
- **Cas spéciaux existants** (BossFenouille, Potiron, mode draw, résurrection, invocations) :
  à porter comme contraintes/heuristiques dans `Evaluator`/`Planner`, pas comme branches
  ad hoc dans l'exécution.
- **Non-régression** : garder l'ancien pipeline derrière un flag jusqu'à validation A/B
  (opérations + taux de victoire farmer 4x4).
