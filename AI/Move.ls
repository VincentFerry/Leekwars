function get_cellules_accessibles(cellIni, mp) {
var global_all_cells_around=null;
var global_all_cells_around_size=null;
    if (global_all_cells_around != null && cellIni == global_all_cells_around[0] && mp == global_all_cells_around_size) return global_all_cells_around;
    if (cellIni == null || mp < 0) return [];
    var range = mp;
    var xIni = getCellX(cellIni);
    var yIni = getCellY(cellIni);
    var res = [];
    push(res, cellIni);
    for (var x = xIni - range; x <= xIni + range; x++) {
        for (var y = yIni - range; y <= yIni + range; y++) {
            var distance = abs(x - xIni) + abs(y - yIni);
            if (distance > range) continue;
            var possible_move = getCellFromXY(x, y);
            if (possible_move != null && getCellContent(possible_move) == CELL_EMPTY) {
                var path_length = getPathLength(cellIni, possible_move);
                if (path_length > 0 && path_length <= mp)
                    push(res, possible_move);
            }
        }
    }
	if(getCell()==cellIni){
		mark(res,COLOR_GREEN,1);
	}else{
		mark(res,COLOR_RED,1);
	}
    return res;
}
// return all cells possible to shoot enemy
// manque AOE
function GetAllCellToShootEnemy(weapon,enemy){
if(isAlive(enemy)){
	var CellEnemy=getCell(enemy);
	var CellEnemy1=areaEnemy1(enemy);
	var MyCells=get_cellules_accessibles(getCell(),getMP());
	var res=[];
	//special chip spark
	for (var i = 0; i <count(MyCells) ; i++) {
		if(weapon==CHIP_SPARK&& getCellDistance(MyCells[i],CellEnemy)<=10){
			push(res,MyCells[i]);
		}
	}
	if(getCooldown(weapon)==0){
		// not inline
		if(!isInline_weapon_chip(weapon)){
			for (var i = 0; i <count(MyCells) ; i++) {
				if(lineOfSight(MyCells[i], CellEnemy)&& getCellDistance(MyCells[i],CellEnemy)<=_get_weapon_or_chip_max_range(weapon)&& getCellDistance(MyCells[i],CellEnemy)>=_get_weapon_or_chip_min_range(weapon)){
					push(res,MyCells[i]);
				}else if(_get_weapon_or_chip_area(weapon)>2){ // croix
					for (var y = 0; y <count(CellEnemy1) ; y++) {
						if(lineOfSight(MyCells[i], CellEnemy1[y])&& getCellDistance(MyCells[i],CellEnemy1[y])<=_get_weapon_or_chip_max_range(weapon)&& getCellDistance(MyCells[i],CellEnemy1[y])>=_get_weapon_or_chip_min_range(weapon)){
							push(res,MyCells[i]);
						}
					}
				}
			}
			mark(res,COLOR_RED, 1);
			return res;
		// inline
		}else{
				for (var i = 0; i <count(MyCells) ; i++) {
					if(lineOfSight(MyCells[i], CellEnemy,getallsummon())&& getCellDistance(MyCells[i],CellEnemy)<=_get_weapon_or_chip_max_range(weapon)&&getCellDistance(MyCells[i],CellEnemy)>=_get_weapon_or_chip_min_range(weapon) && isOnSameLine(MyCells[i],CellEnemy)){
						push(res,MyCells[i]);
					}
				}
				mark(res, COLOR_BLUE, 1);
				return res;
			}

	}else{
		return res;
	}
}
}
function GetFarCellToShootEnemy(weapon,enemy){
// si tu touches sans bouger 
	if(isWeapon(weapon)){
		if(canUseWeapon(weapon,enemy)){
			return getCell();
		}else if(canUseChip(weapon, enemy)){
			return getCell();
		}
	}
// sinon
var tab=GetAllCellToShootEnemy(weapon,enemy);var temp=999999;var res;
		for (var i = 0; i < count(tab); i++) {
			if(temp > getPathLength(tab[i],getCell())){
				temp=getPathLength(tab[i],getCell());
				res=tab[i];
			}
		}
		return res;
}
function MoveToCell(cell){
	moveTowardCell(cell, getMP());
}

// cout en opé a ameliorer
// Si on peut pas se cacher, éviter de se mettre ne ligne avec l'enemy
function cache_cache(){
var tab_me=get_cellules_accessibles(getCell(getLeek()),getMP(getLeek()));
var enemy = getNearestEnemy();
var tab_enemy=get_cellules_accessibles(getCell(enemy), getMP(enemy));
var safe=tab_me;var res;
// on choppe les cases safes avec ldv + po
	for(var i=0;i<count(tab_me);i++){
		for(var y=0;y<count(tab_enemy);y++){
		if(lineOfSight(tab_me[i], tab_enemy[y])&&getDistance(tab_me[i],tab_enemy[y])<=10){
				removeElement(safe, tab_me[i]);
				mark(tab_me[i], COLOR_RED, 1);
			}
		}
	}
	safe=arrayFlatten(safe);
	// on choppe la case safe la plus proche de l'enemy
	if(!isEmpty(safe)){
	var temp=9999;
		for (var i = 0; i < count(safe); i++) {
			if(temp>getPathLength(getCell(enemy), safe[i])){
				temp=getPathLength(getCell(enemy), safe[i]);
				res=safe[i];
			}
		}
	}
	mark(res,COLOR_BLUE,1);
	return res;
}
function GetBestMove(weapon,enemy){
	if(isEmpty(GetAllCellToShootEnemy(weapon,enemy))){
		return cache_cache();
	}else{
		return GetFarCellToShootEnemy(weapon,enemy);
	}
}