class Potiron {
	/* Item a avoir 
	 * TP, Winged_bot, jump, bulbe foudroyant */
	static Map<string,integer|string> glagolitique = [:];
	static Array says = [];
	static Array saysHistory = [];
	static setGlagolitique() {
		Potiron.glagolitique['Ⰰ'] = 1;
		Potiron.glagolitique['Ⰱ'] = 2;
		Potiron.glagolitique['Ⰲ'] = 3;
		Potiron.glagolitique['Ⰳ'] = 4;
		Potiron.glagolitique['Ⰴ'] = 5;
		Potiron.glagolitique['Ⰵ'] = 6;
		Potiron.glagolitique['Ⰶ'] = 7;
		Potiron.glagolitique['Ⰷ'] = 8;
		Potiron.glagolitique['Ⰸ'] = 9;
		Potiron.glagolitique['Ⰹ'] = 10;
		Potiron.glagolitique['Ⰻ'] = 20;
		Potiron.glagolitique['Ⰼ'] = 30;
		Potiron.glagolitique['Ⰽ'] = 40;
		Potiron.glagolitique['Ⰾ'] = 50;
		Potiron.glagolitique['Ⰿ'] = 60;
		Potiron.glagolitique['Ⱀ'] = 70;
		Potiron.glagolitique['Ⱁ'] = 80;
		Potiron.glagolitique['Ⱂ'] = 90;
		Potiron.glagolitique['Ⱃ'] = 100;
		Potiron.glagolitique['Ⱄ'] = 200;
		Potiron.glagolitique['Ⱅ'] = 300;
		Potiron.glagolitique['Ⱆ'] = 400;
		Potiron.glagolitique['Ⱇ'] = 500;
		Potiron.glagolitique['Ⱈ'] = 600;
		Potiron.glagolitique['Ⱉ'] = 700;
		Potiron.glagolitique['Ⱋ'] = 800;
		Potiron.glagolitique['Ⱌ'] = 900;
		Potiron.glagolitique['Ⱍ'] = 1000;
	}
	
	static saysLists() {
		return listen();
	}
	
	static integer|string decodeMessage(string msg) {
		integer msgLength = length(msg);
		integer|string res = 0;
		for (var i = 0; i<msgLength; i++) {
			if (!mapContainsKey(Potiron.glagolitique, charAt(msg, i))) {
				debugE('caractère : ' + charAt(msg, i));pause();
			} else {
				res += Potiron.glagolitique[charAt(msg, i)];
			}
		}
		return res;
	}
	
	static Array getAllNumbers(Array nbs) {
		if (count(nbs) == 1) return nbs;
		var res = [];
		for (integer key : integer nb in nbs) {
			var remaining = arrayConcat(arraySlice(nbs, 0, key), arraySlice(nbs, key+1));
			var remainingPermutations = getAllNumbers(remaining);
			for (integer cle : var number in remainingPermutations) {
				var permutation = string(nb) + remainingPermutations[cle];
      			push(res, permutation);
			}
		}
		return res;
	}
	
	static integer getPrimeSum(Array nbs) {
		Array<integer> res = [];
		Array<integer> divisibleByPrime = [];
		
		for (string nb in nbs) {
			integer tempNb = number(nb);
			integer tempCumul = 1;
			Array<integer> tmpPrimes = [];
			integer countPrimes = count(Cache.primesNumbers);
			for (integer i = 0; i < countPrimes; i++) {
				if (tempNb % Cache.primesNumbers[i] == 0) {
					push(tmpPrimes, Cache.primesNumbers[i]);
					tempNb = tempNb / Cache.primesNumbers[i];
					i = -1;
				}
			}
			for (integer y in tmpPrimes) {
				tempCumul *= y;
			}
			if (tempCumul > 1 && tempCumul < 614) {
				push(res, tempCumul);
			}
		}
		return arrayMax(res);
	}
	
	static integer? getCellRes() {
		integer? finalRes = null;
		Potiron.setGlagolitique();
		Potiron.getLastSays();
		if (count(Potiron.says) % 3 == 0) {
			Array decodedSays = [];
			for (var says in Potiron.says) {
				for (var say in says) {
					if (contains(say, "!")) return null;
					if (typeOf(say) == TYPE_STRING) {
						push(decodedSays, Potiron.decodeMessage(say));
					}
				}
			}
			
			var allNumbers = Potiron.getAllNumbers(decodedSays);
			finalRes = Potiron.getPrimeSum(allNumbers);
			debug(allNumbers);
			debug(finalRes);
			//show(finalRes);
			pause();
		} else if (isSummon()) {
			Array messages = getMessages();
			if (messages) {
				moveTowardCell(messages[0][2], getMP());
				Cache.leeks[getEntity()].mp = 0;
			}
			debug('messages : ' + messages);
			pause();
		} else {
			debug('says : ' + Potiron.says);
		}
		return isEmptyCell(finalRes) ? finalRes : null;
	}
	
	static getLastSays() {
		Array tempListen = listen();
		integer nbListen = count(tempListen);
		for (Array say in tempListen) {
			if (contains(say[1], '!!')) continue;
			Potiron.says = arraySlice(tempListen, nbListen - 3, nbListen);
			push(Potiron.saysHistory, say); // on stocke entité + say
		}
	}
	
	/*
	 * 1- cellAccess
	 * 2- cellAccess + jump
	 * 3- cellAccess + boost mp and jump ?
	 * 4 - invocation ?
	 * 5 - TP
	 * 6- invoc + poussé ! peut choper presque toutes la map.
	 * */
	static coverCell(integer cellToCover, integer myId) {
		Leek me = Cache.leeks[myId];
		useChip(CHIP_WINGED_BOOTS);
		me.cellAccess = Carte.getCellulesAccessibles(me.cell, getMP());
		me.mp = getMP();
		
		// cell Access
		if (mapContainsKey(me.cellAccess, cellToCover)) {
			moveTowardCell(cellToCover);
			Cache.leeks[myId].mp = 0;
			Cache.forceNoMove = true;
			debug('cover with mp');
			return;
		}
		// Todo with jump
		if (!me.chipsCooldown[CHIP_JUMP] && me.chipsCooldown[CHIP_JUMP] != null) {
			Map<integer,integer> cellAccessJump = Carte.cellAccessJump(me);
			Map<integer, integer> cellJumpOnly;
			for (integer cell : integer value in cellAccessJump) {
				if (!mapContainsKey(me.cellAccess, cell) && Carte.isEmptyCell(cell)) {
					cellJumpOnly[cell] = value;
				}
			}
			if (mapContainsKey(cellJumpOnly, cellToCover)) {
				integer cellToJump;
				integer tempDist = 99;
				integer tempDist2;
				integer tempCell;
				for (var cell : var osef in Cache.areaCell3[cellAccessJump[cellToCover]]) {
					tempCell = cell;
					tempDist2 = getCellDistance(tempCell, cellToCover);
					if (tempDist2 < tempDist && Carte.isEmptyCell(cell)) {
						cellToJump = cell;
						tempDist = tempDist2;
					}
				}
				moveTowardCell(cellJumpOnly[cellToCover]);
				useChipOnCell(CHIP_JUMP, cellToJump);
				moveTowardCell(cellToCover);
				Cache.leeks[myId].mp = 0;
				debug('cover with jump');
				Cache.forceNoMove = true;
				return;
			}
		}
		// Todo with tp
		if (!me.chipsCooldown[CHIP_TELEPORTATION] && me.chipsCooldown[CHIP_TELEPORTATION] != null) {
			Map<integer,integer> cellAccessTp = Carte.cellAccessTp(me.cell, getMP());
			if (mapContainsKey(cellAccessTp, cellToCover)) {
				moveTowardCell(cellAccessTp[cellToCover]);
				useChipOnCell(CHIP_TELEPORTATION, cellToCover);
				Cache.leeks[myId].mp = 0;
				Cache.forceNoMove = true;
				debug('cover with tp');
				return;
			}
		}
		
		// with CHIP_LIGHTNING_BULB for t1 because after we have tp
		if (!me.chipsCooldown[CHIP_LIGHTNING_BULB] && me.chipsCooldown[CHIP_LIGHTNING_BULB] != null) {
			Item chip_bulb = Cache.items[CHIP_LIGHTNING_BULB];
			Map<integer,integer> cellInvoc = Carte.getCellulesAccessibles(cellToCover, 6); // mp CHIP_LIGHTNING_BULB
			for (integer myCell : var key in me.cellAccess) {
				for (integer cellInvocLightning : var cle in cellInvoc) {
					if (!lineOfSight(myCell, cellInvocLightning) && chip_bulb.needLos) {
						continue;
					}
					if (getCellDistance(myCell, cellInvocLightning) > chip_bulb.maxRange) {
						continue;
					}
					if (getCellDistance(myCell, cellInvocLightning) < chip_bulb.minRange) {
						continue;
					}
					var action = new Action(me, chip_bulb, myCell, cellInvocLightning);
					Action.useAction(me.id, action);
					Cache.leeks[myId].mp = 0;
					sendTo(getSummons()[0], MESSAGE_MOVE_TOWARD_CELL, cellToCover);
					debug('cover with invoc');
					return;
				}
			}
		}
		debug('not cover');
		debug('cell to cover : ' + cellToCover + ', my cell : ' + me.cell);pause();
	}
}