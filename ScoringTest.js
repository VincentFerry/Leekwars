/* Test à lancer en 1v1 sans obstacles.*/
class ScoringTest{

    static boolean active = false;
    static boolean testAction = false;

    static void run() {
        integer me = getEntity();
        integer enemy = getNearestEnemy();
        if (ScoringTest.testAction) {
            Cache.leeks[me].life = 1500;
            Cache.leeks[me].strength = 0;
            Cache.leeks[me].wisdom = 500;
            Cache.leeks[me].science = 0;
            Cache.leeks[me].resistance = 0;
            Cache.leeks[enemy].life = 1500;
            Cache.items[CHIP_INVERSION].effects[2][1] = 100;
            Cache.items[CHIP_INVERSION].effects[2][2] = 100;
            Cache.items[WEAPON_J_LASER].effects[0][1] = 100;
            Cache.items[WEAPON_J_LASER].effects[0][2] = 100;
            Cache.items[WEAPON_J_LASER].cost = 1;
        }

        Map<string, Object> res = [:]
        //(Array effect, integer entity, Leek leek, real prio, real entityPrio, real areaMulti, Item item)
        res['heal'] = Scoring.getPrioHeal(Cache.items[CHIP_REMISSION].effects[0], me, Cache.leeks[me], 1, 1, Cache.items[CHIP_REMISSION]);
        res['buffStrength'] = Scoring.getPrioBuffStrength(Cache.items[CHIP_PROTEIN].effects[0], me, Cache.leeks[me], 1, 1, Cache.items[CHIP_PROTEIN]);
        res['rawGeneric'] = Scoring.getPrioRawBuffGeneric(Cache.items[CHIP_PROTEIN].effects[0], me, Cache.leeks[me], 1, 1, Cache.items[CHIP_PROTEIN]);
        res['buffTP'] = Scoring.getPrioBuffTp(Cache.items[CHIP_MOTIVATION].effects[0], me, Cache.leeks[me], 1, 1, Cache.items[CHIP_MOTIVATION]);
        res['absoluteShield'] = Scoring.getPrioAbsoluteShield(Cache.items[CHIP_HELMET].effects[0], me, Cache.leeks[me], 1, 1, Cache.items[CHIP_HELMET]);
        res['relativeShield'] = Scoring.getPrioRelativeShield(Cache.items[CHIP_WALL].effects[0], me, Cache.leeks[me], 1, 1, Cache.items[CHIP_WALL]);
        res['novaVitality'] = Scoring.getPrioNovaVitality(Cache.items[CHIP_MUTATION].effects[0], me, Cache.leeks[me], 1, 1, Cache.items[CHIP_MUTATION]);
        res['maxHeal'] = Scoring.getPrioBoostMaxLife(Cache.items[CHIP_ARMORING].effects[0], me, Cache.leeks[me], 1, 1, Cache.items[CHIP_ARMORING]);
        res['absoluteVulnerability'] = Scoring.getPrioAbsoluteVulnerability(Cache.items[WEAPON_J_LASER].effects[0], enemy, Cache.leeks[me], 1, 1, Cache.items[WEAPON_J_LASER]);
        res['vulnerability'] = Scoring.getPrioVulnerability(Cache.items[CHIP_INVERSION].effects[2], enemy, Cache.leeks[me], 1, 1, Cache.items[CHIP_INVERSION]);
        res['damage'] = Scoring.getPrioDamage(Cache.items[CHIP_SHOCK].effects[0], enemy, Cache.leeks[me], 1, 1, Cache.items[CHIP_SHOCK]);

        for (string effect : Object row in res) {
            debug('effect ' + effect + ' : ' + row);
        }
        pause();
    }
}