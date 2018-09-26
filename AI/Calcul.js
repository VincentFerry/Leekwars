include("Include");
// retourne les dégats en fonction de la force
function calcPower(damage, force) {
  return damage*(1+force/100);
}
// retourne les dégats en fonction des shields
function calcDamage(damage, enemyAbsoluteShield, enemyRelativeShield) {
  return max(0, (damage*(100-enemyRelativeShield)/100)-enemyAbsoluteShield);
}
// calcul du shiel
function calcAbsoluteShield(shield, agility) {
  return shield*(1+agility/100);
}
// calcul du shiel
function calcRelativeShield(shield, agility) {
  return shield+agility/50;
}
// calcul du heal
function calcHeal(damage, agility) {
  return damage*(1+agility/100);
}
//calcul moyenne des domages
function meanDamages(min, max) {
  return (min + max)/2;
}
// calcul la moyenne des dégats d'une arme
// Faire Pareil pour une Chip
function RealDamage(damage,enemy){
	return calcDamage(calcPower(damage,getStrength()), getAbsoluteShield(enemy), getRelativeShield(enemy));
}
// test si la puce est déja active
function AlreadyBuff(leek,chip){
	var res=false;
	var buff=getEffects(leek);
	for(var i=0;i<count(buff);i++){
		if(chip==buff[i][5]){
			res=true;
		}
	}
	return res;
}
function cankill(enemy){
	var vie=getLife(enemy);
	var mydmg=getTP()*getDamagePerTp(BestWeapon(enemy),enemy);
	if(vie<mydmg){
		debug("T ES MORT !!!");
		debug("mydmg"+mydmg);
		return true;
	}else{
		return false;
	}
}
function candie(enemy){
	var vie=getLife();
	var weapons=getWeapons(enemy);
	var temp=0;
	var force=getStrength(enemy);
	var absoluteshield=getAbsoluteShield();
	var relativeshield=getRelativeShield();
	var weaponcost;
	for (var i = 0; i <count(weapons); i++) {
		if(temp<getWeaponAverageDamage(weapons[i])){
			temp=getWeaponAverageDamage(weapons[i]);
			weaponcost=getWeaponCost(weapons[i]);
		}
	}
	var damageparcout=calcDamage(calcPower(temp,force), absoluteshield, relativeshield);
	var Realdmgpertp=damageparcout/weaponcost;
	var dmg=Realdmgpertp*getTP(enemy);
	debug('degats potentiel enemy '+dmg+' ma vie '+vie);
	if(vie<dmg){
	debug("je suis probablement mort");
		return true;
	}else{
	debug("alive");
		return false;
	}
}
function getDamagePercentage(cell1, cell2, area)
{
	if (cell1 == cell2) return 1/100;
	var dist = getCellDistance(cell1, cell2);
	var areaDist = 0;
	if(AREA_CIRCLE_1 == area)
		areaDist = 1;
	else if(AREA_CIRCLE_2 == area)
		areaDist = 2;
	else if(AREA_CIRCLE_3 == area)
		areaDist = 3;
	if(dist > areaDist )
		return 0;
	return 1/(100 - ((50 / areaDist) * dist));
}