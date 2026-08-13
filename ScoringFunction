class ScoringFunction {
    private functionRef;

    constructor(func) {
        this.functionRef = func;
    }

    public call(Array effect, integer entity, Leek leek,real entityPrio, real areaMulti, Item item) {
        return this.functionRef(effect, entity, leek, entityPrio, areaMulti, item);
    }

    public call2(Array effect, integer cellFrom, integer cellTo, integer entity) {
        return this.functionRef(effect, cellFrom, cellTo, entity);
    }
}
