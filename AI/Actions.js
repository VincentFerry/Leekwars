include("Include");
function ShootWithWeapon(weapon,enemy){
var myCell=getCell();
// test 4 cases pour le laser
var MyCellXP=getCellFromXY(getCellX(myCell)+2, getCellY(myCell));
var MyCellXM=getCellFromXY(getCellX(myCell)-2, getCellY(myCell));
var MyCellYP=getCellFromXY(getCellX(myCell), getCellY(myCell)+2);
var MyCellYM=getCellFromXY(getCellX(myCell), getCellY(myCell))-2;
var EnemyCell=getCell(enemy);
	if(isWeapon(weapon)){
		if(canUseWeapon(weapon,enemy)){
			while(getTP()>=getWeaponCost(weapon)){
				useWeapon(enemy);
			}
		}else if(_get_weapon_or_chip_area(weapon)>2){
			while(getTP()>=getWeaponCost(weapon)){
				for (var i = 0; i <count(areaEnemy1(enemy)) ; i++) {
					useWeaponOnCell(areaEnemy1(enemy)[i]);
					debug(" CA MARCHE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
				}
			}
		// dégueulasse mais on fait comme on peut #lazer into bulbe
		}else if(search(getWeaponEffectiveArea(weapon ,MyCellXP ),EnemyCell)){
			useWeaponOnCell(MyCellXP);
		}else if(search(getWeaponEffectiveArea(weapon ,MyCellXM ),EnemyCell)){
			useWeaponOnCell(MyCellXM);
		}else if(search(getWeaponEffectiveArea(weapon ,MyCellYP ),EnemyCell)){
			useWeaponOnCell(MyCellYP);
		}else if(search(getWeaponEffectiveArea(weapon ,MyCellYM ),EnemyCell)){
			useWeaponOnCell(MyCellYM);
		}
	}else{
		if(canUseChip(weapon,enemy)){
			while(getTP()>=getChipCost(weapon)&&getCooldown(weapon)==0){
				useChip(weapon, enemy);
			}
		}else if(_get_weapon_or_chip_area>2){
			while(getTP()>=getChipCost(weapon)){
				for (var i = 0; i <count(areaEnemy1(enemy)) ; i++) {
					useChipOnCell(weapon,areaEnemy1(enemy)[i]);
				}
			}
		}
	}
}
function invocbulb(){
	if(!isSummon()&&count(getAliveAllies())<5){
		summon(CHIP_PUNY_BULB, getcellinvocBulb(), bulbAI);
	}
}
function Boost(){
	if(isSummon()){
	var leek=getSummoner();
		for (var i = 0; i < count(get_chips_boost(getLeek())); i++) {
			if(!AlreadyBuff(leek, get_chips_boost(getLeek())[i])){
					useChip(get_chips_boost(getLeek())[i], leek);
			}
		}
	}else{
		for (var i = 0; i < count(get_chips_boost(getLeek())); i++) {
			if(!AlreadyBuff(getLeek(), get_chips_boost(getLeek())[i])){
					useChip(get_chips_boost(getLeek())[i], getLeek());
			}
		}
	}
	
}
function Heal(){
useChip(CHIP_ARMORING, getLeek());
if(isSummon()){
	var leek=getSummoner();
	if(getLife(leek)!=getTotalLife(leek)){	
		for (var i = 0; i < count(get_chips_heal(getLeek())); i++) {
		// TEMPORAIRE POUR USE CHIP VACCINE FIRST
			useChip(get_chips_heal(getLeek())[i], leek);
		}
	}
}else{
	if(getLife()!=getTotalLife()){	
		for (var i = 0; i < count(get_chips_heal(getLeek())); i++) {
		// TEMPORAIRE POUR USE CHIP VACCINE FIRST
			if(search(get_chips_heal(getLeek()), 11)){
				useChip(11, getLeek());
			}
			if(get_chips_heal(getLeek())[i]!=CHIP_REGENERATION){
				useChip(get_chips_heal(getLeek())[i], getLeek());	
			}			
		}
	}
	
}
}
function Shield(){
if(isSummon()){
	var leek=getSummoner();
	for (var i = 0; i < count(get_chips_shield(getLeek())); i++) {
		if(!AlreadyBuff(leek, get_chips_shield(getLeek())[i])){
				useChip(get_chips_shield(getLeek())[i], leek);
		}
	}
}else{
	useChip(CHIP_FORTRESS, getLeek());
	useChip(CHIP_WALL, getLeek());
	for (var i = 0; i < count(get_chips_shield(getLeek())); i++) {
		if(!AlreadyBuff(getLeek(), get_chips_shield(getLeek())[i])){
				useChip(get_chips_shield(getLeek())[i], getLeek());
		}
	}
}
	
}
// A Supprimer 
function SeCacher(enemy){
	if(cache_cache()==null && getTurn()<30){
		moveAwayFrom(enemy);
	}else if((cache_cache()!=null)){
		moveTowardCell(cache_cache());
	}else{
		moveToward(enemy);
	}
}
function ChangeWeapon(weapon){
	if(isWeapon(weapon)&& getWeapon()!=weapon){
		setWeapon(weapon);
	}
}
function DoAction(enemy){
var bulbe=getNearestEnemy();
var MyBestWeapon = BestWeapon(enemy);
var damageperTPBestWeapon = getDamagePerTp(BestWeapon(enemy),enemy);
if(!isEmpty(getweaponcanshootenemy(enemy))&& damageperTPBestWeapon>=(getAverageRegisters()/100)*55){
setRegister(getTurn(),damageperTPBestWeapon);
}
debug("Liste des armes dispo : "+getweaponcanshootenemy(enemy));
debug("Moyenne des Registers : "+getAverageRegisters());
debug("Degat actuel Per TP: "+damageperTPBestWeapon);
// attaque leek
while(!isEmpty(getweaponcanshootenemy(enemy))&& getDamagePerTp(BestWeapon(enemy),enemy)>((getAverageRegisters()/100)*55) && getTP()>getWeaponCost(BestWeapon(enemy))){
	debug("best weapon :"+ _get_weapon_or_chip_name(BestWeapon(enemy)));
	MoveToCell(GetFarCellToShootEnemy(BestWeapon(enemy),enemy));
	ChangeWeapon(BestWeapon(enemy));
	ShootWithWeapon(BestWeapon(enemy), enemy);
}
//attaque bulbe
while(!isEmpty(getweaponcanshootenemy(bulbe))&& getDamagePerTp(BestWeapon(bulbe),bulbe)>((getAverageRegisters()/100)*55) && getTP()>getWeaponCost(BestWeapon(bulbe))){
	debug("best weapon :"+ _get_weapon_or_chip_name(BestWeapon(bulbe)));
	MoveToCell(GetFarCellToShootEnemy(BestWeapon(bulbe),bulbe));
	ChangeWeapon(BestWeapon(bulbe));
	ShootWithWeapon(BestWeapon(bulbe), bulbe);
}
SeCacher(enemy);
}
function TestDoAntidote(){
	var tab=getEffects(getLeek());
	var Poison=0;
	for(var i=0;i<count(tab);i++){
		if(tab[i][0]==EFFECT_POISON){
			Poison=Poison+1;
		}
	}
	// Si j'ai 3 poisons sur ma gueule
	if(Poison>=3){
	debug("Je me debuff !!");
	useChip(CHIP_ANTIDOTE, getLeek());
	}
}