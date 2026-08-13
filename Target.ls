class Target {
	integer leekId
	integer effectId
	real value
	real priority
	constructor(integer leekId, integer effectId, real value) {
		this.leekId = leekId;
		this.effectId = effectId;
		this.value = value;
	}

	private void addPriority(real priority) {
		this.priority = priority;
	}
}