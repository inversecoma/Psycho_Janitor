package custom
{
	import flash.net.SharedObject;

	public class GlobalData
	{
		public static var sharedObject:SharedObject;
		
		//player stats
		public static var playerSpeed:int 	 = 1;
		public static var playerStrength:int = 1;
		public static var playerHealth:int	 = 3;
		//weapons
		public static var weaponSelected:int 	   = 1;
		public static var weapon1Purchased:Boolean = true;
		public static var weapon2Purchased:Boolean = false;
		public static var weapon3Purchased:Boolean = false;
		//modifier
		public static var modifierSelected:int 		 = 0;
		public static var modifier1Purchased:Boolean = false;
		public static var modifier2Purchased:Boolean = false;
		public static var modifier3Purchased:Boolean = false;
		//misc
		public static var money:int 		= 100;
		public static var bestDistance:int	= 0;
		public static var mostKills:int 	= 0;
		public static var deaths:int 		= 0;
	
		public function GlobalData():void
		{
			sharedObject = SharedObject.getLocal("psychoJanitorData");
			
			if(sharedObject.data.firstTimePlaying == null)
			{
				sharedObject.data.firstTimePlaying = false;
				
				saveData();
			}
			else
			{
				setData();
			}
		}
		
		public static function saveData():void
		{
			sharedObject.data.playerSpeed 			= GlobalData.playerSpeed;
			sharedObject.data.playerStrength 		= GlobalData.playerStrength;
			sharedObject.data.playerHealth 			= GlobalData.playerHealth;
			
			sharedObject.data.weaponSelected 		= GlobalData.weaponSelected;
			sharedObject.data.weapon1Purchased 		= GlobalData.weapon1Purchased;
			sharedObject.data.weapon2Purchased 		= GlobalData.weapon2Purchased;
			sharedObject.data.weapon3Purchased 		= GlobalData.weapon3Purchased;
			
			sharedObject.data.modifierSelected 		= GlobalData.modifierSelected;
			sharedObject.data.modifier1Purchased 	= GlobalData.modifier1Purchased;
			sharedObject.data.modifier2Purchased 	= GlobalData.modifier2Purchased;
			sharedObject.data.modifier3Purchased 	= GlobalData.modifier3Purchased;
			
			sharedObject.data.money 				= GlobalData.money;
			sharedObject.data.bestDistance 			= GlobalData.bestDistance;
			sharedObject.data.mostKills 			= GlobalData.mostKills;
			sharedObject.data.deaths 				= GlobalData.deaths;
			
			sharedObject.flush();
		}
		
		private static function setData():void
		{
			GlobalData.playerSpeed 			= sharedObject.data.playerSpeed;
			GlobalData.playerStrength 		= sharedObject.data.playerStrength;
			GlobalData.playerHealth 		= sharedObject.data.playerHealth;
			
			GlobalData.weaponSelected 		= sharedObject.data.weaponSelected;
			GlobalData.weapon1Purchased 	= sharedObject.data.weapon1Purchased;
			GlobalData.weapon2Purchased 	= sharedObject.data.weapon2Purchased;
			GlobalData.weapon3Purchased 	= sharedObject.data.weapon3Purchased;
			
			GlobalData.modifierSelected 	= sharedObject.data.modifierSelected;
			GlobalData.modifier1Purchased	= sharedObject.data.modifier1Purchased;
			GlobalData.modifier2Purchased 	= sharedObject.data.modifier2Purchased;
			GlobalData.modifier3Purchased 	= sharedObject.data.modifier3Purchased;
			
			GlobalData.money 				= sharedObject.data.money;
			GlobalData.bestDistance 		= sharedObject.data.bestDistance;
			GlobalData.mostKills 			= sharedObject.data.mostKills;
			GlobalData.deaths 				= sharedObject.data.deaths;
		}
	}
}