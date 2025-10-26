class Weapon extends Item {
	constructor(integer id) {
		this.id = id
    	this.name = getWeaponName(id);
    	this.launchType = getWeaponLaunchType(id);
		this.area = getWeaponArea(id);
		this.cost = getWeaponCost(id);
		this.effects = getWeaponEffects(id);
		this.maxRange = getWeaponMaxRange(id);
		this.minRange = getWeaponMinRange(id);
		this.cooldown = 0;
		this.needLos = weaponNeedLos(id);
		this.launchType = getWeaponLaunchType(id);
		this.maxUse = max(1, getWeaponMaxUses(id));
		this.is_weapon = true;
		super.getMainTarget();
	}
	getItemEffectiveArea(integer cell, integer cellTo) {
		return getWeaponEffectiveArea(this.id, cellTo, cell);
	}
	boolean isEntityInArea(integer cell, integer cellTo) {
		Array<integer> cells = getWeaponEffectiveArea(this.id, cellTo, cell);
		for (integer cellule in cells) {
			if (isEntity(cellule)) {
				return true;
			}
		}
		return false;
	}
}