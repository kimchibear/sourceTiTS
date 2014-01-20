package classes.Items.Apparel 
{
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class GooeyCoverings extends ItemSlotClass
	{
		
		public function GooeyCoverings() 
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.MELEE_WEAPON;
			
			//Used on inventory buttons
			this.shortName = "gooverings";
			
			//Regular name
			this.longName = "gooey coverings";
			
			//Longass shit, not sure what used for yet.
			this.description = "gooey coverings";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "Shoop da goop.";
			this.attackVerb = "";
			
			//Information
			this.basePrice = 150;
			this.attack = 0;
			this.damage = 4;
			this.damageType = GLOBAL.PIERCING;
			this.defense = 50;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 0;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 0;
			this.bonusResistances = new Array(0,0,0,0,0,0,0,0);

			this.version = _latestVersion;
		}
		
	}

}