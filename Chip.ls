include('ScoringTest');
class Chip extends Item {
	constructor(integer id) {
		this.id = id
    	this.name = getChipName(id);
    	this.launchType = getChipLaunchType(id);
		this.area = getChipArea(id);
		this.cost = getChipCost(id);
		this.effects = getChipEffects(id);
		this.maxRange = getChipMaxRange(id);
		this.minRange = getChipMinRange(id);
		this.cooldown = getChipCooldown(id);
		this.needLos = (id == CHIP_BOXING_GLOVE) ? false  : chipNeedLos(id);
		this.launchType = getChipLaunchType(id);
		this.is_weapon = false;
		this.maxUse = max(1, getChipMaxUses(id)); // return -1 if there is a coldown
		super.getMainTarget();
		if (ScoringTest.active && ScoringTest.testAction) {
			this.effects[0][1] = 100;
			this.effects[0][2] = 100;
			this.effects[0][3] = 1;
			this.cost = 1;
		}
	}
	Array<integer> getItemEffectiveArea(integer cell, integer cellEnemy) {
		return getChipEffectiveArea(this.id, cellEnemy, cell);
	}

	boolean isEntityInArea(integer cell, integer cellEnemy) {
		Array<integer> cells = getChipEffectiveArea(this.id, cellEnemy, cell);
		for (integer cellule in cells) {
			if (isEntity(cellule)) {
				return true;
			}
		}
		return false;
	}
}