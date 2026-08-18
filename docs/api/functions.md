# Fonctions Leek Wars

> Référence complète des fonctions disponibles dans les scripts IA.

**Types :** `int`=1/6, `String`=2, `bool`=3, `null`=4, `Array`=5, `Number`=7, `void`=8

## Mathématiques

### `abs(int number) -> int`
- **Coût :** 2 opérations

### `acos(int argument) -> Number`
- **Coût :** 12 opérations

### `asin(int argument) -> Number`
- **Coût :** 12 opérations

### `atan(int argument) -> Number`
- **Coût :** 25 opérations

### `atan2(int y, int x) -> Number`
- **Coût :** 35 opérations

### `binString(int x) -> String`
- **Coût :** 10 opérations

### `bitCount(int x) -> int`
- **Coût :** 1 opérations

### `bitLength(int x) -> int`
- **Coût :** 1 opérations

### `bitReverse(int x) -> int`
- **Coût :** 1 opérations

### `bitsToReal(int x) -> Number`
- **Coût :** 1 opérations

### `byteReverse(int x) -> int`
- **Coût :** 1 opérations

### `cbrt(int number) -> Number`
- **Coût :** 62 opérations

### `ceil(int number) -> int`
- **Coût :** 2 opérations

### `cos(int angle) -> Number`
- **Coût :** 30 opérations

### `exp(int number) -> Number`
- **Coût :** 40 opérations

### `floor(int number) -> int`
- **Coût :** 2 opérations

### `hexString(int x) -> String`
- **Coût :** 10 opérations

### `hypot(int x, int y) -> Number`
- **Coût :** 187 opérations

### `isFinite(Number x) -> bool`
- **Coût :** 1 opérations

### `isInfinite(Number x) -> bool`
- **Coût :** 1 opérations

### `isNaN(Number x) -> bool`
- **Coût :** 1 opérations

### `isPermutation(int x, int y) -> bool`
- **Coût :** 50 opérations

### `leadingZeros(int x) -> int`
- **Coût :** 1 opérations

### `log(int number) -> Number`
- **Coût :** 39 opérations

### `log10(int number) -> Number`
- **Coût :** 23 opérations

### `log2(int number) -> Number`
- **Coût :** 1 opérations

### `max(int a, int b) -> int`
- **Coût :** 2 opérations

### `min(int a, int b) -> int`
- **Coût :** 2 opérations

### `number(-1 value) -> Number`
- **Coût :** 20 opérations

### `pow(int base, int exp) -> Number`
- **Coût :** 140 opérations

### `rand() -> Number`
- **Coût :** 30 opérations

### `randFloat(int a, int b) -> int` ⚠️ DEPRECATED
- **Coût :** 30 opérations

### `randInt(int a, int b) -> int`
- **Coût :** 30 opérations

### `randReal(Number a, Number b) -> Number`
- **Coût :** 30 opérations

### `realBits(Number x) -> int`
- **Coût :** 1 opérations

### `rotateLeft(int x, int s) -> int`
- **Coût :** 1 opérations

### `rotateRight(int x, int s) -> int`
- **Coût :** 1 opérations

### `round(int number) -> int`
- **Coût :** 2 opérations

### `setBit(int x, int bit, int value) -> int`
- **Coût :** 1 opérations

### `signum(int number) -> int`
- **Coût :** 2 opérations

### `sin(int angle) -> Number`
- **Coût :** 30 opérations

### `sqrt(int number) -> Number`
- **Coût :** 8 opérations

### `tan(int angle) -> Number`
- **Coût :** 30 opérations

### `testBit(int x, int bit) -> bool`
- **Coût :** 1 opérations

### `toDegrees(int radians) -> Number`
- **Coût :** 1 opérations

### `toRadians(int degrees) -> Number`
- **Coût :** 31 opérations

### `trailingZeros(int x) -> int`
- **Coût :** 1 opérations

## Chaînes

### `charAt(String string, int position) -> String`
- **Coût :** 8 opérations

### `codePointAt(String string, int index) -> int`
- **Coût :** 5 opérations

### `contains(String string, String search) -> bool`
- **Coût :** -1 opérations

### `endsWith(String string, String suffix) -> bool`
- **Coût :** -1 opérations

### `indexOf(String string, String search, int start) -> int`
- **Coût :** -1 opérations

### `length(String string) -> int`
- **Coût :** 15 opérations

### `replace(String string, String search, String replace) -> String`
- **Coût :** -1 opérations

### `split(String string, String delimiter, int limit) -> 42`
- **Coût :** -1 opérations

### `startsWith(String string, String prefix) -> bool`
- **Coût :** -1 opérations

### `string(-1 value) -> String`
- **Coût :** 8 opérations

### `substring(String string, int start, int length) -> String`
- **Coût :** -1 opérations

### `toLower(String string) -> String`
- **Coût :** -1 opérations

### `toUpper(String string) -> String`
- **Coût :** -1 opérations

## Tableaux

### `arrayChunk(null array, int chunkSize) -> 44`
- **Coût :** 1 opérations

### `arrayClear(null array) -> 0`
- **Coût :** 2 opérations

### `arrayConcat(null array1, null array2) -> null`
- **Coût :** -1 opérations

### `arrayEvery(null array, Array callback) -> bool`
- **Coût :** 1 opérations

### `arrayFilter(null array, Array callback) -> null`
- **Coût :** -1 opérations

### `arrayFind(null array, Array callback) -> -1`
- **Coût :** -1 opérations

### `arrayFlatten(null array, int depth) -> null`
- **Coût :** -1 opérations

### `arrayFoldLeft(null array, Array f, -1 v0) -> -1`
- **Coût :** -1 opérations

### `arrayFoldRight(null array, Array f, -1 v0) -> -1`
- **Coût :** -1 opérations

### `arrayFrequencies(null array) -> 806`
- **Coût :** 1 opérations

### `arrayGet(null array, int index, -1 defaultValue) -> -1`
- **Coût :** 1 opérations

### `arrayIter(null array, Array callback) -> 0`
- **Coût :** -1 opérations

### `arrayMap(null array, Array callback) -> null`
- **Coût :** -1 opérations

### `arrayMax(null array) -> -1`
- **Coût :** -1 opérations

### `arrayMin(null array) -> -1`
- **Coût :** -1 opérations

### `arrayPartition(null array, Array callback) -> 44`
- **Coût :** -1 opérations

### `arrayRandom(null array, int count) -> null`
- **Coût :** 1 opérations

### `arrayRemoveAll(null array, -1 element) -> 0`
- **Coût :** -1 opérations

### `arraySlice(null array, -1 start, -1 end, int stride) -> null`
- **Coût :** -1 opérations

### `arraySome(null array, Array callback) -> bool`
- **Coût :** 1 opérations

### `arraySort(null array, Array callback) -> null`
- **Coût :** -1 opérations

### `arrayToSet(null array) -> 9`
- **Coût :** 1 opérations

### `arrayUnique(null array) -> null`
- **Coût :** 1 opérations

### `assocSort(null array, int order) -> 0` ⚠️ DEPRECATED
- **Coût :** -1 opérations

### `average(41 array) -> Number`
- **Coût :** -1 opérations

### `count(null array) -> int`
- **Coût :** 1 opérations

### `fill(null array, -1 value, int size) -> 0`
- **Coût :** -1 opérations

### `inArray(null array, -1 element) -> bool`
- **Coût :** -1 opérations

### `insert(null array, -1 element, int position) -> 0`
- **Coût :** -1 opérations

### `isEmpty(null array) -> bool`
- **Coût :** 2 opérations

### `join(null array, String glue) -> String`
- **Coût :** -1 opérations

### `keySort(null array, int order) -> 0`
- **Coût :** -1 opérations

### `pop(null array) -> -1`
- **Coût :** 5 opérations

### `push(null array, -1 element) -> 0`
- **Coût :** 2 opérations

### `pushAll(null array, null elements) -> 0`
- **Coût :** -1 opérations

### `remove(null array, int position) -> -1`
- **Coût :** -1 opérations

### `removeElement(null array, -1 element) -> 0`
- **Coût :** -1 opérations

### `removeKey(null array, -1 key) -> 0`
- **Coût :** 5 opérations

### `reverse(null array) -> 0`
- **Coût :** -1 opérations

### `search(null array, -1 element, int start) -> int`
- **Coût :** -1 opérations

### `shift(null array) -> -1`
- **Coût :** -1 opérations

### `shuffle(null array) -> 0`
- **Coût :** -1 opérations

### `sort(null array, int order) -> 0`
- **Coût :** -1 opérations

### `subArray(null array, int start, int end) -> null`
- **Coût :** -1 opérations

### `sum(41 array) -> Number`
- **Coût :** -1 opérations

### `unshift(null array, -1 element) -> 0`
- **Coût :** -1 opérations

## Utilitaires

### `mapAverage(void map) -> Number`
- **Coût :** -1 opérations

### `mapClear(void map) -> 0`
- **Coût :** 1 opérations

### `mapContains(void map, -1 value) -> bool`
- **Coût :** -1 opérations

### `mapContainsKey(void map, -1 key) -> bool`
- **Coût :** 2 opérations

### `mapEvery(void map, Array callback) -> bool`
- **Coût :** -1 opérations

### `mapFill(void map, -1 value) -> 0`
- **Coût :** -1 opérations

### `mapFilter(void map, Array callback) -> void`
- **Coût :** -1 opérations

### `mapFold(void map, Array f, -1 v) -> -1`
- **Coût :** -1 opérations

### `mapGet(void map, -1 key, -1 default) -> -1`
- **Coût :** 2 opérations

### `mapIsEmpty(void map) -> bool`
- **Coût :** 2 opérations

### `mapIter(void map, Array callback) -> 0`
- **Coût :** -1 opérations

### `mapKeys(void map) -> null`
- **Coût :** -1 opérations

### `mapMap(void map, Array callback) -> void`
- **Coût :** -1 opérations

### `mapMax(void map) -> Number`
- **Coût :** -1 opérations

### `mapMerge(void map1, void map2) -> void`
- **Coût :** -1 opérations

### `mapMin(void map) -> Number`
- **Coût :** -1 opérations

### `mapPut(void map, -1 key, -1 value) -> -1`
- **Coût :** 3 opérations

### `mapPutAll(void map, void elements) -> 0`
- **Coût :** -1 opérations

### `mapRemove(void map, -1 key) -> -1`
- **Coût :** 2 opérations

### `mapRemoveAll(void map, -1 value) -> 0`
- **Coût :** -1 opérations

### `mapReplace(void map, -1 key, -1 value) -> -1`
- **Coût :** 3 opérations

### `mapReplaceAll(void map1, void map2) -> 0`
- **Coût :** -1 opérations

### `mapSearch(void map, -1 value) -> Number`
- **Coût :** -1 opérations

### `mapSize(void map) -> int`
- **Coût :** 1 opérations

### `mapSome(void map, Array callback) -> bool`
- **Coût :** -1 opérations

### `mapSum(void map) -> Number`
- **Coût :** 1 opérations

### `mapValues(void map) -> null`
- **Coût :** -1 opérations

## Entité / Leek

### `getAIID(int entity) -> int` ⚠️ DEPRECATED
- **Coût :** 15 opérations

### `getAIName(int entity) -> String`
- **Coût :** 15 opérations

### `getAbsoluteShield(int entity) -> int`
- **Coût :** 15 opérations

### `getAgility(int entity) -> int`
- **Coût :** 15 opérations

### `getBirthTurn(int entity) -> int`
- **Coût :** 15 opérations

### `getBulbType(int entity) -> int`
- **Coût :** 15 opérations

### `getCell(int entity) -> int`
- **Coût :** 5 opérations

### `getChestType(int entity) -> int`
- **Coût :** 15 opérations

### `getChips(int entity) -> 46`
- **Coût :** 40 opérations

### `getCompositionName(int entity) -> String`
- **Coût :** 15 opérations

### `getCores(int entity) -> int`
- **Coût :** 15 opérations

### `getDamageReturn(int entity) -> int`
- **Coût :** 15 opérations

### `getEffects(int entity) -> 44`
- **Coût :** 25 opérations

### `getEntity() -> int`
- **Coût :** 5 opérations

### `getEntityTurnOrder(int entity) -> int`
- **Coût :** 30 opérations

### `getFarmerCountry(int entity) -> String`
- **Coût :** 15 opérations

### `getFarmerID(int entity) -> int`
- **Coût :** 15 opérations

### `getFarmerName(int entity) -> String`
- **Coût :** 15 opérations

### `getForce(int entity) -> int` ⚠️ DEPRECATED
- **Coût :** 15 opérations

### `getFrequency(int entity) -> int`
- **Coût :** 15 opérations

### `getItemUses(int item) -> int`
- **Coût :** 15 opérations

### `getLaunchedEffects(int entity) -> 44`
- **Coût :** 25 opérations

### `getLeek() -> int` ⚠️ DEPRECATED
- **Coût :** 5 opérations

### `getLeekID(int entity) -> int`
- **Coût :** 15 opérations

### `getLevel(int entity) -> int`
- **Coût :** 15 opérations

### `getLife(int entity) -> int`
- **Coût :** 15 opérations

### `getMP(int entity) -> int`
- **Coût :** 15 opérations

### `getMagic(int entity) -> int`
- **Coût :** 15 opérations

### `getMobType(int entity) -> int`
- **Coût :** 15 opérations

### `getName(int entity) -> String`
- **Coût :** 15 opérations

### `getPassiveEffects(int entity) -> 44`
- **Coût :** 125 opérations

### `getPower(int entity) -> int`
- **Coût :** 15 opérations

### `getRAM(int entity) -> int`
- **Coût :** 1 opérations

### `getRelativeShield(int entity) -> int`
- **Coût :** 15 opérations

### `getResistance(int entity) -> int`
- **Coût :** 15 opérations

### `getScience(int entity) -> int`
- **Coût :** 15 opérations

### `getSide(int entity) -> int`
- **Coût :** 5 opérations

### `getStates(int entity) -> 96`
- **Coût :** 25 opérations

### `getStrength(int entity) -> int`
- **Coût :** 15 opérations

### `getSummoner(int entity) -> int`
- **Coût :** 15 opérations

### `getSummons(int entity) -> 46`
- **Coût :** 15 opérations

### `getTP(int entity) -> int`
- **Coût :** 15 opérations

### `getTeamID(int entity) -> int`
- **Coût :** 15 opérations

### `getTeamName(int entity) -> String`
- **Coût :** 15 opérations

### `getTotalLife(int entity) -> int`
- **Coût :** 15 opérations

### `getTotalMP(int entity) -> int`
- **Coût :** 15 opérations

### `getTotalTP(int entity) -> int`
- **Coût :** 15 opérations

### `getType(int entity) -> int`
- **Coût :** 15 opérations

### `getWeapon(int entity) -> int`
- **Coût :** 15 opérations

### `getWeapons(int entity) -> 46`
- **Coût :** 50 opérations

### `getWisdom(int entity) -> int`
- **Coût :** 15 opérations

### `isAlive(int entity) -> bool`
- **Coût :** 15 opérations

### `isAlly(int entity) -> bool`
- **Coût :** 15 opérations

### `isDead(int entity) -> bool`
- **Coût :** 15 opérations

### `isEnemy(int entity) -> bool`
- **Coût :** 15 opérations

### `isStatic(int entity) -> bool`
- **Coût :** 15 opérations

### `isSummon(int entity) -> bool`
- **Coût :** 10 opérations

### `listen() -> null`
- **Coût :** 78 opérations

### `say(String message) -> 0`
- **Coût :** 30 opérations

### `setWeapon(int weapon) -> 0`
- **Coût :** 15 opérations

## Combat / Terrain

### `canUseWeapon(int weapon, int entity) -> bool`
- **Coût :** 45 opérations

### `canUseWeaponOnCell(int weapon, int cell) -> bool`
- **Coût :** 45 opérations

### `getAllWeapons() -> 46`
- **Coût :** 200 opérations

### `getWeaponArea(int weapon) -> int`
- **Coût :** 15 opérations

### `getWeaponCost(int weapon) -> int`
- **Coût :** 15 opérations

### `getWeaponEffectiveArea(int weapon, int cell, int from) -> 46`
- **Coût :** 78 opérations

### `getWeaponEffects(int weapon) -> 44`
- **Coût :** 125 opérations

### `getWeaponFailure(int weapon) -> int` ⚠️ DEPRECATED
- **Coût :** 15 opérations

### `getWeaponLaunchType(int weapon) -> int`
- **Coût :** 15 opérations

### `getWeaponMaxRange(int weapon) -> int`
- **Coût :** 15 opérations

### `getWeaponMaxScope(int weapon) -> int` ⚠️ DEPRECATED
- **Coût :** 15 opérations

### `getWeaponMaxUses(int weapon) -> int`
- **Coût :** 15 opérations

### `getWeaponMinRange(int weapon) -> int`
- **Coût :** 15 opérations

### `getWeaponMinScope(int weapon) -> int` ⚠️ DEPRECATED
- **Coût :** 15 opérations

### `getWeaponName(int weapon) -> String`
- **Coût :** 15 opérations

### `getWeaponPassiveEffects(int weapon) -> 44`
- **Coût :** 125 opérations

### `isInlineWeapon(int weapon) -> bool` ⚠️ DEPRECATED
- **Coût :** 10 opérations

### `isWeapon(int value) -> bool`
- **Coût :** 15 opérations

### `useWeapon(int entity) -> int`
- **Coût :** 3000 opérations

### `useWeaponOnCell(int cell) -> int`
- **Coût :** 3000 opérations

### `weaponNeedLos(int weapon) -> bool`
- **Coût :** 10 opérations

## Armes & Chips

### `canUseChip(int chip, int entity) -> bool`
- **Coût :** 45 opérations

### `canUseChipOnCell(int chip, int cell) -> bool`
- **Coût :** 45 opérations

### `chipNeedLos(int chip) -> bool`
- **Coût :** 10 opérations

### `getAllChips() -> 46`
- **Coût :** 200 opérations

### `getChipArea(int chip) -> int`
- **Coût :** 15 opérations

### `getChipCooldown(int chip) -> int`
- **Coût :** 15 opérations

### `getChipCost(int chip) -> int`
- **Coût :** 15 opérations

### `getChipEffectiveArea(int chip, int cell, int from) -> 46`
- **Coût :** 78 opérations

### `getChipEffects(int chip) -> 44`
- **Coût :** 125 opérations

### `getChipFailure(int chip) -> int` ⚠️ DEPRECATED
- **Coût :** 15 opérations

### `getChipLaunchType(int chip) -> int`
- **Coût :** 15 opérations

### `getChipMaxRange(int chip) -> int`
- **Coût :** 15 opérations

### `getChipMaxScope(int chip) -> int` ⚠️ DEPRECATED
- **Coût :** 15 opérations

### `getChipMaxUses(int chip) -> int`
- **Coût :** 15 opérations

### `getChipMinRange(int chip) -> int`
- **Coût :** 15 opérations

### `getChipMinScope(int chip) -> int` ⚠️ DEPRECATED
- **Coût :** 15 opérations

### `getChipName(int chip) -> String`
- **Coût :** 15 opérations

### `getCooldown(int chip, int entity) -> int`
- **Coût :** 30 opérations

### `isChip(int value) -> bool`
- **Coût :** 10 opérations

### `isInlineChip(int chip) -> bool` ⚠️ DEPRECATED
- **Coût :** 10 opérations

### `resurrect(int entity, int cell) -> int`
- **Coût :** 500 opérations

### `summon(int chip, int cell, Array ai, String name) -> int`
- **Coût :** 1750 opérations

### `useChip(int chip, int entity) -> int`
- **Coût :** 3000 opérations

### `useChipOnCell(int chip, int cell) -> int`
- **Coût :** 3000 opérations

## Effets & Boucliers

### `getCellContent(int cell) -> int`
- **Coût :** 6 opérations

### `getCellDistance(int cell1, int cell2) -> int`
- **Coût :** 15 opérations

### `getCellFromXY(int x, int y) -> int`
- **Coût :** 5 opérations

### `getCellX(int cell) -> int`
- **Coût :** 5 opérations

### `getCellY(int cell) -> int`
- **Coût :** 5 opérations

### `getDistance(int cell1, int cell2) -> int` ⚠️ DEPRECATED
- **Coût :** 15 opérations

### `getEntityOnCell(int cell) -> int`
- **Coût :** 15 opérations

### `getLeekOnCell(int cell) -> int` ⚠️ DEPRECATED
- **Coût :** 15 opérations

### `getMapType() -> int`
- **Coût :** 5 opérations

### `getObstacles() -> 46`
- **Coût :** 85 opérations

### `getPath(int start, int end, 46 ignoredCells) -> 46`
- **Coût :** -1 opérations

### `getPathLength(int cell1, int cell2, 46 ignoredCells) -> int`
- **Coût :** -1 opérations

### `isEmptyCell(int cell) -> bool`
- **Coût :** 10 opérations

### `isEntity(int cell) -> bool`
- **Coût :** 1 opérations

### `isLeek(int cell) -> bool` ⚠️ DEPRECATED
- **Coût :** 10 opérations

### `isObstacle(int cell) -> bool`
- **Coût :** 10 opérations

### `isOnSameLine(int cell1, int cell2) -> bool`
- **Coût :** 15 opérations

## Équipe & Alliés

### `getAliveAllies() -> 46`
- **Coût :** 100 opérations

### `getAliveAlliesCount() -> int`
- **Coût :** 25 opérations

### `getAliveEnemies() -> 46`
- **Coût :** 100 opérations

### `getAliveEnemiesCount() -> int`
- **Coût :** 25 opérations

### `getAllEffects() -> 46`
- **Coût :** 200 opérations

### `getAlliedTurret() -> int`
- **Coût :** 15 opérations

### `getAllies() -> 46`
- **Coût :** 100 opérations

### `getAlliesCount() -> int`
- **Coût :** 25 opérations

### `getAlliesLife() -> int`
- **Coût :** 50 opérations

### `getBulbCharacteristics(int bulbChip) -> void` ⚠️ DEPRECATED
- **Coût :** 40 opérations

### `getBulbChips(int bulbChip) -> 46`
- **Coût :** 40 opérations

### `getBulbStats(int bulbChip) -> void`
- **Coût :** 40 opérations

### `getCellToUseChip(int chip, int entity, 46 ignoredCells) -> int`
- **Coût :** 38080 opérations

### `getCellToUseChipOnCell(int chip, int cell, 46 ignoredCells) -> int`
- **Coût :** 38080 opérations

### `getCellToUseWeapon(int weapon, int entity, 46 ignoredCells) -> int`
- **Coût :** 38080 opérations

### `getCellToUseWeaponOnCell(int weapon, int cell, 46 ignoredCells) -> int`
- **Coût :** 38080 opérations

### `getCellsToUseChip(int chip, int entity, 46 ignoredCells) -> 46`
- **Coût :** 25834 opérations

### `getCellsToUseChipOnCell(int chip, int cell, 46 ignoredCells) -> 46`
- **Coût :** 25834 opérations

### `getCellsToUseWeapon(int weapon, int entity, 46 ignoredCells) -> 46`
- **Coût :** 25834 opérations

### `getCellsToUseWeaponOnCell(int weapon, int cell, 46 ignoredCells) -> 46`
- **Coût :** 25834 opérations

### `getChipTargets(int chip, int cell) -> 46`
- **Coût :** 40 opérations

### `getDeadAllies() -> 46`
- **Coût :** 100 opérations

### `getDeadEnemies() -> 46`
- **Coût :** 100 opérations

### `getDeadEnemiesCount() -> int`
- **Coût :** 25 opérations

### `getEnemies() -> 46`
- **Coût :** 100 opérations

### `getEnemiesCount() -> int`
- **Coût :** 25 opérations

### `getEnemiesLife() -> int`
- **Coût :** 50 opérations

### `getEnemyTurret() -> int`
- **Coût :** 15 opérations

### `getFarthestAlly() -> int`
- **Coût :** 31 opérations

### `getFarthestEnemy() -> int`
- **Coût :** 31 opérations

### `getFightBoss() -> int`
- **Coût :** 10 opérations

### `getFightContext() -> int`
- **Coût :** 10 opérations

### `getFightID() -> int`
- **Coût :** 5 opérations

### `getFightType() -> int`
- **Coût :** 10 opérations

### `getNearestAlly() -> int`
- **Coût :** 25 opérations

### `getNearestAllyTo(int entity) -> int`
- **Coût :** 35 opérations

### `getNearestAllyToCell(int cell) -> int`
- **Coût :** 35 opérations

### `getNearestEnemy() -> int`
- **Coût :** 25 opérations

### `getNearestEnemyTo(int entity) -> int`
- **Coût :** 35 opérations

### `getNearestEnemyToCell(int cell) -> int`
- **Coût :** 35 opérations

### `getNextPlayer(int entity) -> int`
- **Coût :** 20 opérations

### `getPreviousPlayer(int entity) -> int`
- **Coût :** 20 opérations

### `getTurn() -> int`
- **Coût :** 15 opérations

### `getWeaponTargets(int weapon, int cell) -> 46`
- **Coût :** 40 opérations

### `getWinner() -> int`
- **Coût :** 5 opérations

### `lineOfSight(int start, int end, int entityToIgnore) -> bool`
- **Coût :** 31 opérations

### `moveAwayFrom(int entity, int mp) -> int`
- **Coût :** 500 opérations

### `moveAwayFromCell(int cell, int mp) -> int`
- **Coût :** 500 opérations

### `moveAwayFromCells(41 cells, int mp) -> int`
- **Coût :** 500 opérations

### `moveAwayFromEntities(46 entities, int mp) -> int`
- **Coût :** 500 opérations

### `moveAwayFromLeeks(41 entities, int mp) -> int` ⚠️ DEPRECATED
- **Coût :** 500 opérations

### `moveAwayFromLine(int cell1, int cell2, int mp) -> int`
- **Coût :** 500 opérations

### `moveToward(int entity, int mp) -> int`
- **Coût :** 500 opérations

### `moveTowardCell(int cell, int mp) -> int`
- **Coût :** 500 opérations

### `moveTowardCells(46 cells, int mp) -> int`
- **Coût :** 500 opérations

### `moveTowardEntities(46 entities, int mp) -> int`
- **Coût :** 500 opérations

### `moveTowardLeeks(46 leeks, int mp) -> int` ⚠️ DEPRECATED
- **Coût :** 500 opérations

### `moveTowardLine(int cell1, int cell2, int mp) -> int`
- **Coût :** 500 opérations

### `setLoadout(String name, bool changeStats) -> bool`
- **Coût :** 100 opérations

## Intelligence

### `clearMarks() -> 0`
- **Coût :** 15 opérations

### `clone(-1 value, int level) -> -1`
- **Coût :** -1 opérations

### `debug(-1 object) -> 0`
- **Coût :** 100 opérations

### `debugC(-1 object, int color) -> 0`
- **Coût :** 100 opérations

### `debugE(-1 object) -> 0`
- **Coût :** 100 opérations

### `debugW(-1 object) -> 0`
- **Coût :** 100 opérations

### `deleteRegister(String key) -> 0`
- **Coût :** 16 opérations

### `getDate() -> String`
- **Coût :** 50 opérations

### `getInstructionsCount() -> int` ⚠️ DEPRECATED
- **Coût :** 15 opérations

### `getMaxOperations() -> int`
- **Coût :** 1 opérations

### `getMaxRAM() -> int`
- **Coût :** 1 opérations

### `getOperations() -> int`
- **Coût :** 1 opérations

### `getRegister(String key) -> String`
- **Coût :** 15 opérations

### `getRegisters() -> 42`
- **Coût :** 25 opérations

### `getTime() -> String`
- **Coût :** 50 opérations

### `getTimestamp() -> int`
- **Coût :** 5 opérations

### `getUsedRAM() -> int`
- **Coût :** 1 opérations

### `include(String ai) -> 0`
- **Coût :** 1 opérations

### `jsonDecode(String json) -> -1`
- **Coût :** -1 opérations

### `jsonEncode(String object) -> String`
- **Coût :** -1 opérations

### `mark(-1 cells, int color, int duration) -> bool`
- **Coût :** 164 opérations

### `markText(-1 cells, String text, int color, int duration) -> bool`
- **Coût :** 164 opérations

### `pause() -> 0`
- **Coût :** 30 opérations

### `setRegister(String key, String value) -> bool`
- **Coût :** 50 opérations

### `show(int cell, int color) -> 0`
- **Coût :** 8 opérations

### `typeOf(-1 value) -> int`
- **Coût :** 8 opérations

## Débogage

### `getMessageAuthor(null message) -> int`
- **Coût :** 5 opérations

### `getMessageParams(null message) -> -1`
- **Coût :** 5 opérations

### `getMessageType(null message) -> int`
- **Coût :** 5 opérations

### `getMessages(int entity) -> 44`
- **Coût :** -1 opérations

### `sendAll(int type, -1 params) -> 0`
- **Coût :** 40 opérations

### `sendTo(int entity, int type, -1 params) -> bool`
- **Coût :** 15 opérations

## Objets

### `getBlue(int color) -> int`
- **Coût :** 10 opérations

### `getColor(int red, int green, int blue) -> int`
- **Coût :** 15 opérations

### `getGreen(int color) -> int`
- **Coût :** 10 opérations

### `getRed(int color) -> int`
- **Coût :** 10 opérations

## Invocations

### `setClear(9 set) -> 9`
- **Coût :** 1 opérations

### `setContains(9 set, -1 element) -> bool`
- **Coût :** 2 opérations

### `setDifference(9 set1, 9 set2) -> 9`
- **Coût :** 1 opérations

### `setDisjunction(9 set1, 9 set2) -> 9`
- **Coût :** 1 opérations

### `setFilter(9 set, Array callback) -> 9`
- **Coût :** -1 opérations

### `setIntersection(9 set1, 9 set2) -> 9`
- **Coût :** 1 opérations

### `setIsEmpty(9 set) -> bool`
- **Coût :** 2 opérations

### `setIsSubsetOf(9 set1, 9 set2) -> bool`
- **Coût :** 1 opérations

### `setPut(9 set, -1 element) -> bool`
- **Coût :** 3 opérations

### `setRemove(9 set, -1 element) -> bool`
- **Coût :** 2 opérations

### `setSize(9 set) -> int`
- **Coût :** 1 opérations

### `setToArray(9 set) -> null`
- **Coût :** 1 opérations

### `setUnion(9 set1, 9 set2) -> 9`
- **Coût :** 1 opérations

## Autres

### `intervalAverage(10 interval) -> Number`
- **Coût :** 3 opérations

### `intervalCombine(10 interval1, 10 interval2) -> 10`
- **Coût :** 3 opérations

### `intervalContains(10 interval, int value) -> bool`
- **Coût :** 2 opérations

### `intervalIntersection(10 interval1, 10 interval2) -> 10`
- **Coût :** 3 opérations

### `intervalIsBounded(10 interval) -> bool`
- **Coût :** 1 opérations

### `intervalIsClosed(10 interval) -> bool`
- **Coût :** 1 opérations

### `intervalIsEmpty(10 interval) -> bool`
- **Coût :** 1 opérations

### `intervalIsLeftBounded(10 interval) -> bool`
- **Coût :** 1 opérations

### `intervalIsLeftClosed(10 interval) -> bool`
- **Coût :** 1 opérations

### `intervalIsRightBounded(10 interval) -> bool`
- **Coût :** 1 opérations

### `intervalIsRightClosed(10 interval) -> bool`
- **Coût :** 1 opérations

### `intervalMax(10 interval) -> int`
- **Coût :** 1 opérations

### `intervalMin(10 interval) -> int`
- **Coût :** 1 opérations

### `intervalSize(10 interval) -> int`
- **Coût :** 1 opérations

### `intervalToArray(10 interval, int step) -> null`
- **Coût :** 1 opérations

### `intervalToSet(10 interval) -> 9`
- **Coût :** 1 opérations

