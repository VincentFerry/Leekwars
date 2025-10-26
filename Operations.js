class Operations {
	static Map<string, integer> currentOpe = [:];
	static boolean debugOpe = false;
	
	//static integer currentFunctionCall = 0;
	static startOp(string title){
		if (!Operations.debugOpe) return;
		Operations.currentOpe[title] = getOperations();
	}
	static stopOp(string title) {
		if (!Operations.debugOpe) return;
		integer ops = getOperations()-Operations.currentOpe[title] - 3;
		var limit = 600000;
		if (ops > limit ) {
			debugW('fonction supérier à ' + limit + ' d opé');
		}
		debug("Operations (" + title + ") : " + ops +  "\n"+ "il me reste " + getOperations() + " sur " + getMaxOperations());
	}
}