package classes.GameData.Pregnancy.Handlers 
{
	import classes.Creature;
	import classes.GameData.Pregnancy.BasePregnancyHandler;
	import classes.PregnancyData;
	import classes.kGAMECLASS;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class RenvraEggPregnancy extends BasePregnancyHandler
	{
		
		public function RenvraEggPregnancy() 
		{
			_handlesType = "RenvraEggPregnancy";
			_basePregnancyIncubationTime = 10080;
			_basePregnancyChance = 0.1;
			_alwaysImpregnate = false;
			_ignoreInfertility = true;
			_ignoreMotherInfertility = true;
			_ignoreFatherInfertility = true;
			_allowMultiplePregnancies = true;
			_canImpregnateButt = true;
			_canImpregnateVagina = true;
			_canFertilizeEggs = false;
			_pregnancyQuantityMinimum = 2;
			_pregnancyQuantityMaximum = 2;
			
			this.addStageProgression(8000, function(pregSlot:int):void {
				kGAMECLASS.pc.bellyRatingMod += 10;
				(kGAMECLASS.pc.pregnancyData[pregSlot] as PregnancyData).pregnancyBellyRatingContribution += 10;
			}, true);
			
			this.addStageProgression(6000, function(pregSlot:int):void {
				kGAMECLASS.pc.bellyRatingMod += 15;
				(kGAMECLASS.pc.pregnancyData[pregSlot] as PregnancyData).pregnancyBellyRatingContribution += 15;
			}, true);
			
			this.addStageProgression(4000, function(pregSlot:int):void {
				kGAMECLASS.pc.bellyRatingMod += 20;
				(kGAMECLASS.pc.pregnancyData[pregSlot] as PregnancyData).pregnancyBellyRatingContribution += 20;
			}, true);
			
			this.addStageProgression(2000, function(pregSlot:int):void {
				kGAMECLASS.pc.bellyRatingMod += 20;
				(kGAMECLASS.pc.pregnancyData[pregSlot] as PregnancyData).pregnancyBellyRatingContribution += 20;
			}, true);
			
			this.addStageProgression(240, function():void {
				kGAMECLASS.pc.bellyRatingMod += 20;
				(kGAMECLASS.pc.pregnancyData[pregSlot] as PregnancyData).pregnancyBellyRatingContribution += 20;
				eventBuffer += "You note that your swollen belly is shifting awkwardly. The eggs clinging inside you rumble and move, and you feel distinctly... wet. You doubt you'll be carrying these eggs around with you much longer.";
			});
			
			_onSuccessfulImpregnation = renvraOnSuccesfulImpregnation;
			_onSuccessfulImpregnationOutput = renvraOnSuccessfulImpregnationOutput;
			_onFailedImpregnationOutput = renvraOnFailedImpregnationOutput;
			_onDurationEnd = renvraOnDurationEnd;
		}
		
		public static function renvraOnSuccesfulImpregnation(father:Creature, mother:Creature, pregSlot:int, thisPtr:BasePregnancyHandler):void
		{
			(mother.pregnancyData[pregSlot] as PregnancyData).pregnancyBellyRatingContribution += 30;
			mother.bellyRatingMod += 30;
			mother.createStatusEffect("Renvra Eggs Messages Available");
		}
		
		public static function renvraEggsMessageHandler(inPublicSpace:Boolean = false, minutes:Number):String
		{
			if (flags["RENVRA_EGGS_MESSAGE_WEIGHT"] == undefined) flags["RENVRA_EGGS_MESSAGE_WEIGHT"] = 0;
			flags["RENVRA_EGGS_MESSAGE_WEIGHT"] += minutes;
			
			if (rand(360) >= flags["RENVRA_EGGS_MESSAGE_WEIGHT"])
			{
				flags["RENVRA_EGGS_MESSAGE_WEIGHT"] = 0;
				if (!inPublicSpace)
				{
					eventBuffer += "\n\nYou stop yourself, seemingly at random, and plant a hand soothingly over your [pc.belly]. The eggs inside you shift slightly, making your";
					var pSlot:int = kGAMECLASS.pc.getPregnancyOfType("RenvraEggPregnancy");
					if (pSlot == 4) eventBuffer += " stomach rumble";
					else eventBuffer += " belly tremble";
					 eventBuffer += ". It's surprisingly nice to just rub your belly, enjoying the fullness of it.";
					}
				}
				else
				{
					eventBuffer += "As you walk through town, people occasionally walk up to you, asking to feel your belly or how far along you are. You don't have the heart to tell them you're full of alien eggs.";
					if (kGAMECLASS.pc.isBimbo() || kGAMECLASS.pc.isTreated() || kGAMECLASS.pc.race().indexOf("ausar") != -1 || kGAMECLASS.pc.race().indexOf("") != -1 ) eventBuffer += "Besides, people rubbing all over you feels super good!";
				}
			}
		}
				
		public static function renvraOnSuccessfulImpregnationOutput(father:Creature, mother:Creature, thisPtr:BasePregnancyHandler):void
		{
			kGAMECLASS.eventBuffer += "\n\n<b>Your belly is swollen with nyrea eggs, distending your gut as if you were truly pregnant.</b> Hopefully, the eggs will pass quickly. Until then, you spend the next few minutes trying to adjust yourself and your equipment to your new size. Walking just got really awkward....";
		}
		
		public static function renvraOnFailedImpregnationOutput(father:Creature, mother:Creature, thisPtr:BasePregnancyHandler):void
		{
			kGAMECLASS.eventBuffer += "\n\nYou feel a rumbling in your gut, and your belly starts to deflate a bit. Looks like you're absorbing those eggs, slowly but surely...\n\nMaybe you'll stop feeling so full in a while.";
		}
		
		public static function renvraOnDurationEnd(mother:Creature, pregSlot:int, thisPtr:BasePregnancyHandler):void
		{
			// Closures.
			var tEventCall:Function = (function(c_mother:Creature, c_pregSlot:int, c_thisPtr:BasePregnancyHandler):Function
			{
				return function():void
				{
					kGAMECLASS.renvraEggnancyEnds(c_pregSlot);
					RenvraEggPregnancy.cleanupPregnancy(c_mother, c_pregSlot, c_thisPtr);
				}
			})(mother, pregSlot, c_thisPtr);
			
			kGAMECLASS.eventQueue.push(tEventCall);
		}
		
		public static function cleanupPregnancy(mother:Creature, pregSlot:int, thisPtr:BasePregnancyHandler):void
		{
			var pData:PregnancyData = mother.pregnancyData[pregSlot] as PregnancyData;
			
			mother.bellyRatingMod -= pData.pregnancyBellyRatingContribution;
			
			pData.reset();
			
			StatTracking.track("pregnancy/renvra eggs");
			StatTracking.track("pregnancy/total births");
		}
		
		override public function pregBellyFragment(target:Creature, slot:int):String
		{
			return "Your belly is bulging heavily. At first glance, people might be mistaken for thinking you're properly pregnant, but closer inspection reveals your belly to be lumpy and slightly misshapen, bulging with eggs as you are.";
		}
	}

}