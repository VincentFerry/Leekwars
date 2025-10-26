class Item {
    id
    name
    launchType
	area
	cost
	Array effects
	maxRange
	minRange
	cooldown
	needLos
	boolean is_weapon
	string mainTarget
	real damagePerTp
	integer maxUse
	
	/* @TODO Faire un main target plus précis avec les bulbes en utilisant effect[5] modifier */
	getMainTarget() {
		if (this.id == CHIP_GRAPPLE || this.id == CHIP_BOXING_GLOVE) {
			this.mainTarget = 'enemy';
		} else if (mapContainsKey(Cache.chipsShield, this.id) || mapContainsKey(Cache.chipsHeal, this.id) || mapContainsKey(Cache.chipsBoost, this.id) || mapContainsKey(Cache.chipsDamageReturn, this.id) || mapContainsKey(Cache.targetAlly, this.id)) {
			this.mainTarget = 'ally';
			return;
		} else if (mapContainsKey(Cache.chipsDamage, this.id) || this.is_weapon || this.id == CHIP_LIBERATION || this.id == CHIP_INVERSION || this.id == CHIP_COVETOUSNESS || mapContainsKey(Cache.chipsShackle, this.id) || this.id == CHIP_GRAPPLE || this.id == CHIP_BOXING_GLOVE) {
			this.mainTarget = 'enemy';
			return;
		} else if (mapContainsKey(Cache.chipsSummon, this.id)) {
			this.mainTarget = 'cellSummon';
		} else {
			//debugW('Item target not coded : ' + this.name);
		}
	}
}