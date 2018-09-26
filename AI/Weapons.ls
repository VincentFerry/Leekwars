function _get_weapon_or_chip_area(weapon){
 	if (weapon == null) return;
	return isWeapon(weapon) ? getWeaponArea(weapon) : getChipArea(weapon);
}
function _get_weapon_or_chip_cost(weapon) {
    if (weapon == null) return;
    return (isWeapon(weapon) ? getWeaponCost(weapon) : getChipCost(weapon));
}
function _get_weapon_or_chip_name(weapon) {
    if (weapon == null) return;
    return (isWeapon(weapon) ? getWeaponName(weapon) : getChipName(weapon));
}
function _get_weapon_or_chip_min_range(weapon){
	  if (weapon == null) return;
	  return (isWeapon(weapon) ? getWeaponMinRange(weapon) : getChipMinRange(weapon));
}
function _get_weapon_or_chip_max_range(weapon){
	  if (weapon == null) return;
	  return (isWeapon(weapon) ? getWeaponMaxRange(weapon) : getChipMaxRange(weapon));
}
function weapon_chip_need_los(weapon) {
    return (isWeapon(weapon) ? weaponNeedLos(weapon) : chipNeedLos(weapon));
}
function isInline_weapon_chip(weapon) {
    return (isWeapon(weapon) ? isInlineWeapon(weapon) : isInlineChip(weapon));
}
function use_weapon_or_chip_on_cell(weapon, cell) {
    return (isWeapon(weapon) ? useWeaponOnCell(cell) : useChipOnCell(weapon, cell));
}
// ou chips
function getWeaponEffect(weapon)
{
	// [type, min, max, turns, targets]
	if(isWeapon(weapon)){
		var effects = getWeaponEffects(weapon);
	
	for (var i = 0; i < count(effects); i++)
		if (effects[i][0] == EFFECT_DAMAGE)
			return effects[i];
	return null;
	}else if(isChip(weapon)){
		var effects = getChipEffects(weapon);
	
	for (var i = 0; i < count(effects); i++)
		if (effects[i][0] == EFFECT_DAMAGE)
			return effects[i];
	return null;
	}
}
// return 1 damage 13 poison
function damage_or_poison(weapon){
	return getWeaponEffect(weapon)[0];
}
//ou chips
function getWeaponAverageDamage(weapon)
{
	if(weapon==null){
		return null;
	}else if(isWeapon(weapon)){
		var effect = getWeaponEffect(weapon);
		return (effect[1] + effect[2]) / 2;
	}else{
		var effect = getChipEffects(weapon);
		return (effect[0][1] + effect[0][2])/2;
	}
}
function getDamagePerTp(weapon,enemy){
	if(weapon==null){
		return null;
	}else if(isWeapon(weapon)){
		return	RealDamage(getWeaponAverageDamage(weapon),enemy)/getWeaponCost(weapon);
	}else{
		return	RealDamage(getWeaponAverageDamage(weapon),enemy)/getChipCost(weapon);
	}

}
function get_chips_damage(leek) {
    var res = [];
    for (var chip in getChips(leek)) {
        var effects = getChipEffects(chip);
        for (var effect in effects) {
            if (effect[0] == EFFECT_DAMAGE) {
                push(res, chip);
            }
        }
    }
    return res;
}
function get_chips_heal(leek) {
    var res = [];
    for (var chip in getChips(leek)) {
        var effects = getChipEffects(chip);
        for (var effect in effects) {
            if (effect[0] == EFFECT_HEAL) {
                push(res, chip);
            }
        }
    }
    return res;
}
function get_chips_boost(leek) {
    var res = [];
    for (var chip in getChips(leek)) {
        var effects = getChipEffects(chip);
        for (var effect in effects) {
            if (effect[0] == EFFECT_BUFF_FORCE || effect[0] == EFFECT_BUFF_AGILITY || effect[0] == EFFECT_BUFF_TP || effect[0] == EFFECT_BUFF_MP ) {
                push(res, chip);
            }
        }
    }
    return res;
}
function get_chips_shield(leek) {
    var res = [];
    for (var chip in getChips(leek)) {
        var effects = getChipEffects(chip);
        for (var effect in effects) {
            if (effect[0] == EFFECT_ABSOLUTE_SHIELD || effect[0] == EFFECT_RELATIVE_SHIELD) {
                push(res, chip);
            }
        }
    }
    return res;
}

// on ajoute les chips damages aux weapons
function get_weapon_or_chip(leek){
	var res=getWeapons(leek);
	for (var i = 0; i <count(get_chips_damage(leek)) ; i++) {
		push(res,get_chips_damage(leek)[i]);
		
	}
	return res;
}
function getweaponcanshootenemy(enemy){
	if(isAlive(enemy)){
		var Allmyweapons=get_weapon_or_chip(getLeek());
		var res=[];
		for (var i = 0; i <count(Allmyweapons) ; i++) {
		if(!isEmpty(GetAllCellToShootEnemy(Allmyweapons[i],enemy)) && _get_weapon_or_chip_cost(Allmyweapons[i])<getTP()){
			push(res, Allmyweapons[i]);
			}
		}
		return res;	
	}else{
		return ;
	}
} 

function BestWeapon(enemy){
	var weapons=getweaponcanshootenemy(enemy);
	var res;var dmg=0;
	for (var i = 0; i < count(weapons); i++) {
		if(dmg<getDamagePerTp(weapons[i],enemy)){
			dmg=getDamagePerTp(weapons[i],enemy);
			res=weapons[i];
		}	
	}
	return res;
}
function CalcDamage(leekAtt,leekDef,damage){
	return calcPower(damage,getStrength(leekAtt))* (1 - getRelativeShield(leekDef) / 100) - getAbsoluteShield(leekDef);
}
