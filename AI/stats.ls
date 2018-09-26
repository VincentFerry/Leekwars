//pour avoir le dernier élément : lifePreviusTurn[count(lifePreviusTurn)-1]

push(life,getLife());// on ajoue la vie actuelle dans la global
function AverageDamageTaken(){
//Dur a calculé avec les heal
}
function GetEnemyStats(enemy)
{   //renvoi un tableau avec toutes les stats du leek
	var EnemyStats = [];
	EnemyStats["vie"]=getTotalLife(enemy);
	EnemyStats["force"]=getStrength(enemy);
	EnemyStats["mp"]=getTotalMP(enemy);
	EnemyStats["tp"]=getTotalTP(enemy);
	EnemyStats["res"]=getResistance(enemy);
	EnemyStats["level"]=getLevel(enemy);
	EnemyStats["wisdom"]=getWisdom(enemy);
	EnemyStats["magie"]=getMagic(enemy);
	EnemyStats["science"]=getScience(enemy);
	EnemyStats["absoBouc"]=getAbsoluteShield(enemy);
	EnemyStats["relaBouc"]=getRelativeShield(enemy);
	return EnemyStats;
}
function areaEnemy1(enemy){
var res=[];
if(isAlive(enemy)){
	var CellEnemy = getCell(enemy);
	var CellEnemyX =getCellX(CellEnemy);
	var CellEnemyY =getCellY(CellEnemy);	
		push(res,getCellFromXY(CellEnemyX+1,CellEnemyY));
		push(res,getCellFromXY(CellEnemyX-1,CellEnemyY));
		push(res,getCellFromXY(CellEnemyX,CellEnemyY+1));
		push(res,getCellFromXY(CellEnemyX,CellEnemyY-1));

}
return res;
}
