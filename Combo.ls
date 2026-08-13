class Combo{
	/**
	 * brut force
	 * */
	static Array<Action> getComboFromActions(integer leekId, Array<Action> actions) {
		Operations.startOp('Combo : getComboFromActions');
		//Leek leek = Cache.leeks[leekId];
		if (count(actions) == 0) return [];
		Array<Action> finalCombos = [];
		integer cpt = 0;
		integer countActions = count(actions);
		
		do {
			while(cpt < countActions && Combo.isValideCombo(actions[cpt], leekId) && getOperations() < getMaxOperations() * 0.9)
			{
				if (actions[cpt].priority <= 15) {
					cpt++;
					continue;
				}
				// LIBERATION always first or nothing
				if (!isEmpty(finalCombos) && actions[cpt].item.id == CHIP_LIBERATION) {
					cpt++;
					continue;
				}
				// add jump action
				if (!mapContainsKey(Cache.leeks[leekId].getCellAccessBase(), actions[cpt].cellFrom)
					&& Cache.leeks[leekId].cell != actions[cpt].cellFrom
					&& Cache.leeks[leekId].chipsCooldown[CHIP_JUMP] == false && inArray(Cache.leeks[leekId].chips, CHIP_JUMP)
					&& Cache.leeks[leekId].tp >= Cache.items[CHIP_JUMP].cost + actions[cpt].item.cost) {
					// get CellFrom
					integer distance = 99;
					integer cellule = Cache.leeks[leekId].cell;
					var mpToUpdate = 0;
					for (integer cell : integer dist in Cache.leeks[leekId].getCellAccessBase()) {
						var tmpDist = getCellDistance(cell, actions[cpt].cellTo);
						if (tmpDist < distance) {
							var tmpPath = getPathLength(Cache.leeks[leekId].cell, cell);
							if (tmpPath <= Cache.leeks[leekId].mp) {
								cellule = cell;
								distance = tmpDist;
								mpToUpdate = tmpPath;
							}
						}
					}
					if (getCellDistance(cellule, actions[cpt].cellFrom) <= Cache.items[CHIP_JUMP].maxRange) {
						// on le gère plus loin du coup
						/*Action jumpAction = new Action(Cache.leeks[leekId], Cache.items[CHIP_JUMP], cellule, actions[cpt].cellFrom);
						Cache.leeks[leekId].mp -= mpToUpdate;
						Cache.leeks[leekId].tp -= Cache.items[CHIP_JUMP].cost;
						Cache.leeks[leekId].chipsCooldown[CHIP_JUMP] = true;
						Cache.leeks[leekId].cell = actions[cpt].cellFrom;
						push(finalCombos, jumpAction);*/
					} else {						
						cpt++;
						continue;
					}
				}

				push(finalCombos, actions[cpt]);
				actions = Leek.updateActions(cpt, actions, leekId);
				countActions = count(actions);
				/*if (cpt > number(getRegister('cpt'))) {
					setRegister('cpt', cpt);
				}*/
			}
			cpt++;
		} while (Cache.leeks[leekId].tp > 0 && cpt < countActions);
		
		if (getOperations() > getMaxOperations() * 0.9) {
			debugW('limite par le nombre d opé');
		}
		if (getTurn() == 5) {
			debug('finalCombos : ');
			debug(finalCombos);
		}
		
		Operations.stopOp('Combo : getComboFromActions');
		
		return finalCombos;
	}
	
	static boolean isValideCombo(Action action, integer leekId) {
		// Pour ne pas utiliser en boucle, on peut pas le vérifier avant
		if (Cache.leeks[leekId].chipsCooldown[action.item.id]) {
			return false;
		}
		
		if (Cache.leeks[leekId].itemMaxUse[action.item.id] == action.item.maxUse) return false;
		
		integer weaponCost = action.item.cost;
		if (action.item.is_weapon) {
			if (!Cache.leeks[leekId].weapon || Cache.leeks[leekId].weapon.id != action.item.id) {
				weaponCost += 1;
			}
		}
		
		if (Cache.leeks[leekId].tp < weaponCost) {
			return false;
		}
		
		if (action.cellFrom == action.cellTo && action.item.area == AREA_POINT) return true; // hardcoded fix
		integer? dist = getPathLength(Cache.leeks[leekId].cell, action.cellFrom, [getCell()]);	

		// Issue without chip jump ??
		if (dist && dist > Cache.leeks[leekId].mp
		&& action.cellFrom != Cache.leeks[leekId].cell
		&& Cache.leeks[leekId].chipsCooldown[CHIP_JUMP] == true
		|| !inArray(Cache.leeks[leekId].chips, CHIP_JUMP)
		|| dist > Cache.leeks[leekId].mp + Cache.items[CHIP_JUMP].maxRange
		|| Cache.leeks[leekId].tp < action.item.cost + Cache.items[CHIP_JUMP].cost) {
			return false;
		}

		return true;
	}
	
	// @todo SORT BY PATH !! J UTILISE DES JUMPS POURRIT JUSTE A CAUSE DE L'ordre !! 
	static Array<Action> sortCombo(Array<Action> actions) {
		Operations.startOp('Combo : sortCombo');
		if (Cache.turn == 1) return actions; // For reflexe first

		var cellIni = getCell();
		Array<Action> sortedActions = arraySort(actions, function(Action a , Action b) {
			// Item sur soit en prio
			if (a.cellFrom == a.cellTo && b.cellFrom != b.cellTo && a.item.area == AREA_POINT) {
				return -1;
			}
			if (a.cellFrom != a.cellTo && b.cellFrom == b.cellTo && b.item.area == AREA_POINT) {
				return 1;
			}

			// Libération after
			if (a.item.id == CHIP_LIBERATION && b.item.id != CHIP_LIBERATION) {
				return -1;
			}
			if (a.item.id != CHIP_LIBERATION && b.item.id == CHIP_LIBERATION) {
				return 1;
			}

			// Calculer les distances par rapport à la position actuelle
			/*integer distA = getCellDistance(cellIni, a.cellFrom);
			integer distB = getCellDistance(cellIni, b.cellFrom);
			if (distA < distB) {
				return -1;
			} else if (distA == distB) {
				return 0;
			} else {
				return 1;
			}*/
		});
		
		Operations.stopOp('Combo : sortCombo');
		return sortedActions;
	}
	
	/* @todo remettre adréaline et inversion juste pour les kills
	 * Combos[99] = adréaline + inversion + épée lourde + machine gun, beaucoup de kills en plus car inversion jamais tester avant épée lourde */
	static getCombos(Array<Action> actions) {
		Operations.startOp('Combo : getCombos');
		integer me = getEntity();
		Cache.resetLeeks();
		// Pourquoi je dois faire ça et le reset leeks ne fonctionne pas juste pour ça ???
		for (integer itemId in arrayConcat(Cache.leeks[me].weapons, Cache.leeks[me].chips)) {
			Cache.leeks[me].itemMaxUse[itemId] = getItemUses(itemId);
		}
		Cache.leeks[me].getChipsCooldown();
		boolean canBoostArealine = false;
		boolean alreadyAdrealine = false;
		boolean chatimentReady = false;
		if (Cache.leeks[me].chipsCooldown[CHIP_PUNISHMENT] == false) {
			chatimentReady = true;
		}
		Map<integer, boolean> hardcodedCombos = [:];
		if (Cache.leeks[me].chipsCooldown[CHIP_ADRENALINE] == false) {
			for (Array buff in Cache.leeks[me].effects) {
				if (CHIP_ADRENALINE == buff[5]) {
					alreadyAdrealine = true;
				}
			}
			if (alreadyAdrealine == false) {
				canBoostArealine = true;
			}
		}
		var tmpTp = canBoostArealine ? Cache.leeks[me].tp + 4 : Cache.leeks[me].tp;

		Map<integer, Array> enemies = [:];
		for (Leek entity in Cache.leeks) {
			if (entity.life > 0 && !entity.ally && entity.type != ENTITY_BULB) {
				enemies[entity.id] = [];
			}
		}

		for (Action action in actions) {
			//if (!mapContainsKey(Cache.chipsDamage, action.item.id) && !action.item.is_weapon) continue;
			if (action.item.id == WEAPON_HEAVY_SWORD) {
				for (Target target in action.targets) {
					if (mapContainsKey(enemies, target.leekId)) {
						push(enemies[target.leekId], action);
					}
				}
			}
		}
		
		for (integer enemyId : Array<Action> actionsOnEnemy  in enemies) {
			// hardcoded combo
			for (Action action in actionsOnEnemy) {
				if (action.item.id == WEAPON_HEAVY_SWORD && !hardcodedCombos[enemyId]) {
					//Action adrealine = new Action(Cache.leeks[me], Cache.items[CHIP_ADRENALINE], action.cellFrom, action.cellFrom);
					Action inversion = new Action(Cache.leeks[me], Cache.items[CHIP_INVERSION], action.cellFrom, action.cellTo);
					Action heavySword = new Action(Cache.leeks[me], Cache.items[WEAPON_HEAVY_SWORD], action.cellFrom, action.cellTo);
					Action heavySwordInversion = new Action(Cache.leeks[me], Cache.items[WEAPON_HEAVY_SWORD], action.cellTo, action.cellFrom);
					Action machineGun = new Action(Cache.leeks[me], Cache.items[WEAPON_MACHINE_GUN], action.cellFrom, action.cellTo);
					Action machineGunInversion = new Action(Cache.leeks[me], Cache.items[WEAPON_MACHINE_GUN], action.cellTo, action.cellFrom);
					Action katanaInversion = new Action(Cache.leeks[me], Cache.items[WEAPON_KATANA], action.cellTo, action.cellFrom);
					Action katana = new Action(Cache.leeks[me], Cache.items[WEAPON_KATANA], action.cellFrom, action.cellTo);
					Action chatiment = new Action(Cache.leeks[me], Cache.items[CHIP_PUNISHMENT], action.cellFrom, action.cellTo);
					Action chatimentInversion = new Action(Cache.leeks[me], Cache.items[CHIP_PUNISHMENT], action.cellTo, action.cellFrom);
					hardcodedCombos[enemyId] = true;
					
					if (Cache.leeks[me].chipsCooldown[CHIP_INVERSION] == false) {
						Cache.leeks[me].combos[90 + enemyId] = [inversion, heavySwordInversion, machineGunInversion, machineGunInversion, machineGunInversion];
						if (tmpTp >= 35) { // depends quelle weapon est équipé.
							if (chatimentReady && Cache.leeks[me].life > 3000) {
								Cache.leeks[me].combos[80 + enemyId] = [inversion, heavySwordInversion, chatimentInversion, katanaInversion, katanaInversion];
							} else {
								Cache.leeks[me].combos[80 + enemyId] = [inversion, heavySwordInversion, katanaInversion, katanaInversion, machineGunInversion];
							}
						} else {
							Cache.leeks[me].combos[80 + enemyId] = [inversion, heavySwordInversion, katanaInversion, katanaInversion];
						}
					} else {
						Cache.leeks[me].combos[90 + enemyId] = [heavySword, machineGun, machineGun, machineGun];
						if (tmpTp >= 35) { // depends quelle weapon est équipé.
							if (chatimentReady && Cache.leeks[me].life > 3000) {
								Cache.leeks[me].combos[80 + enemyId] = [heavySword, chatiment, katana, katana];
							} else {
								Cache.leeks[me].combos[80 + enemyId] = [heavySword, katana, katana, machineGun];
							}
						} else {
							Cache.leeks[me].combos[80 + enemyId] = [heavySword, katana, katana];
						}
					}
				}
			}
			// All damage combos
			if (isEmpty(actionsOnEnemy)) continue;
			Array<Action> subActions = Action.sortActions(actionsOnEnemy, me);
			if (canBoostArealine) {
				Cache.leeks[me].tp += 4;
			}
			Cache.leeks[me].combos[10 + enemyId] = Combo.getComboFromActions(me, actionsOnEnemy);
			if (canBoostArealine) {
				unshift(Cache.leeks[me].combos[10 + enemyId], new Action(Cache.leeks[me], Cache.items[CHIP_ADRENALINE], Cache.leeks[me].cell, Cache.leeks[me].cell));
			}
			
			Cache.LeeksStates[10 + enemyId] = Cache.leeks[enemyId];
			Cache.resetLeeks();
		}

		for (integer enemyId : boolean test in hardcodedCombos) {
				var tmpObjHeavySword = Scoring.getPrioDamage(Cache.items[WEAPON_HEAVY_SWORD].effects[0], enemyId, Cache.leeks[me], 1, 1, Cache.items[WEAPON_HEAVY_SWORD]);
				var tmpObjKatana = Scoring.getPrioDamage(Cache.items[WEAPON_KATANA].effects[0], enemyId, Cache.leeks[me], 1, 1, Cache.items[WEAPON_MACHINE_GUN]);
				var tmpObjMachineGun = Scoring.getPrioDamage(Cache.items[WEAPON_MACHINE_GUN].effects[0], enemyId, Cache.leeks[me], 1, 1, Cache.items[WEAPON_MACHINE_GUN]);

				// heavy sword / machine gun
				Cache.leeks[enemyId].relativeShield -= 20;
				Cache.leeks[enemyId].life -= tmpObjHeavySword.value;
				Cache.leeks[enemyId].absoluteShield -= 60;
				Cache.leeks[enemyId].life -= tmpObjMachineGun.value * 9;
				Cache.LeeksStates[90 + enemyId] = Cache.leeks[enemyId];

				Cache.resetLeeks();
				// heavy sword / katana
				Cache.leeks[enemyId].relativeShield -= 20;
				Cache.leeks[enemyId].life -= tmpObjHeavySword.value;
				Cache.leeks[enemyId].absoluteShield -= 60;
				Cache.leeks[enemyId].life -= tmpObjKatana.value * 2;
				Cache.LeeksStates[80 + enemyId] = Cache.leeks[enemyId];
		}
		
		Operations.stopOp('Combo : getCombos');
	}
	
	static integer evaluateCombos(integer leekId) {
		Operations.startOp('Combo : evaluateCombos');
		Array<integer> enemiesAlives = [];
		integer nbEnemiesAliveStart = 0;
		for (Leek leek in Cache.initLeeks) {
			if (!leek.ally && leek.life > 0 && leek.type != ENTITY_BULB) {
				nbEnemiesAliveStart++;
				push(enemiesAlives, leek.id);
			}
		}
		
		Map<integer,boolean> nbEnemiesAliveWithCombo = [:];
		integer nbEnemiesAliveCombo0 = 0;
		for (integer comboId : Array<Action> actions in Cache.leeks[leekId].combos) {
			if (comboId == 0) {
				for (Leek entity in Cache.LeeksStates[0]) {
					// ajouté + ou - = à 100 ou plus car on prend les jets minimum !
					if (!entity.ally && entity.life > 100 && entity.type != ENTITY_BULB) { 
						nbEnemiesAliveCombo0++;
					}
				}
				if (nbEnemiesAliveCombo0 < nbEnemiesAliveStart) {
					debug('kill with combo 0');
					return 0;
				}
			} else {
				if (!mapContainsKey(Cache.LeeksStates, comboId)) {
					continue;
				}
				// ajouté + ou - = à 100 ou plus car on prend les jets minimum !
				// Faire un ratio avec l'agilité ?
				if (Cache.LeeksStates[comboId].life <= Cache.LeeksStates[comboId].getPassiveDamage() + 100) {
					nbEnemiesAliveWithCombo[comboId] = true;
				} else {
					nbEnemiesAliveWithCombo[comboId] = false;
				}
			}
		}
		
		for (integer comboId : boolean kill in nbEnemiesAliveWithCombo) {
			if (kill) {
				debug('kill with combo : ' + comboId);
				return comboId;
			}
		}
		
		debug('default combo 0');
		Operations.stopOp('Combo : evaluateCombos');
		return 0;
	}
}