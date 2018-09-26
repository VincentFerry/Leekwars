// return le nombre d'opérations utilisés en pourcentages
function getop(){
	if(getTP()!=0){
		debug("Il me reste : "+getTP());
	}
	return debug("J'utilise "+round((getOperations()/OPERATIONS_LIMIT)*100)+"% des opérations");
}
// Message fun si on win
function win(){
	if(count(getAliveEnemies())==0&& getTP()>0){
		say("ez noob free win ggwp");
	}
}
// Supprime all register
function deleteRegisters(){
	deleteRegister('reg1');
	for (var i = 0; i < 65; i++) {
	deleteRegister(i);
	}
}
// Moyenne des Registers
function getAverageRegisters(){
return average(getRegisters());
}
// Retourne le poireau enemy 
function getenemy(){
var Enemies = getEnemies();
var enemy;
	for (var i = 0; i <count(Enemies) ; i++) {
		if(isSummon(Enemies[i])==false){
			enemy=Enemies[i];
		}
	}
	return enemy;
}
function getallsummon(){
	var Enemies = getEnemies();
	var Allies = getAllies();
	var summon=[];
	for (var i = 0; i <count(Enemies) ; i++) {
		if(isSummon(Enemies[i])){
			push(summon,Enemies[i]);
		}
	}
	for (var i = 0; i <count(Allies) ; i++) {
		if(isSummon(Allies[i])){
			push(summon,Allies[i]);
		}
	}
	return summon;
}
// Temporaire car marche pas pour tout les bulbes
function getcellinvocBulb(){
	var cellIni=getCell(getLeek());
	var cellX = getCellX(cellIni);
	var cellY = getCellY(cellIni);
	var res=[];
	if(isEmptyCell(getCellFromXY(cellX-1,cellY))){
		push(res, getCellFromXY(cellX-1,cellY));
	}else if(isEmptyCell(getCellFromXY(cellX+1,cellY))){
		push(res, getCellFromXY(cellX+1,cellY));
	}else if(isEmptyCell(getCellFromXY(cellX,cellY-1))){
		push(res, getCellFromXY(cellX,cellY-1));
	}else if(isEmptyCell(getCellFromXY(cellX,cellY+1))){
		push(res, getCellFromXY(cellX,cellY+1));
	}
	return res[0];
}
function getmaxtab(tab){
	return search(tab, arrayMax(arrayFlatten(tab)));
}
