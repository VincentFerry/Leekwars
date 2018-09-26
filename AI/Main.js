include("Include");
var MonArme = WEAPON_LASER;
if(getTurn()==1){
setWeapon(MonArme); 
}
function main(){
	var enemy = getenemy();
	if(getTurn()==1){
		deleteRegisters();
	}
	if(!cankill(enemy)&&candie(enemy)&&!isSummon()){
		if(getCooldown(CHIP_REGENERATION)==0 && getTotalLife()-getLife()>500){
			useChip(CHIP_REGENERATION,getLeek());
		}else{
			Heal();Shield();SeCacher(enemy);
			debug("j essai de survivre");
		}
	}
	TestDoAntidote();
	DoAction(enemy);
	Heal(); 
	Shield();
	invocbulb();
	Boost();
	getop();
	//win();
}
main();
