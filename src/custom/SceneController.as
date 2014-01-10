package custom
{
	import com.greensock.TweenLite;
	
	import custom.scenes.SceneCredits;
	import custom.scenes.ScenePick;
	import custom.scenes.ScenePlay;
	import custom.scenes.SceneSplash;
	import custom.scenes.SceneStart;
	
	import starling.display.Sprite;
	import starling.events.Event;

	public class SceneController extends Sprite
	{
		public const SPLASH:int  = 0;
		public const START:int 	 = 1;
		public const PLAY:int 	 = 2;
		public const PICK:int 	 = 3;
		public const CREDITS:int = 4;
		
		private var splash:SceneSplash;
		private var start:SceneStart;
		private var play:ScenePlay;
		private var pick:ScenePick;
		private var credits:SceneCredits;

		public function SceneController()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			nav(null, SPLASH);
		}
		
		public function nav(fromScene:Sprite, toScene:int, delay:Number=0):void
		{
			if(delay > 0)
			{
				TweenLite.delayedCall(delay, nav, [fromScene, toScene]);
			}
			else
			{
				if(fromScene)
					fromScene.parent.removeChild(fromScene);
				
				switch(toScene)
				{
					case SPLASH:
						splash = new SceneSplash(this);
						addChild(splash);
						break;
					
					case START:
						start = new SceneStart(this);
						addChild(start);
						break;
					
					case PLAY:
						play = new ScenePlay(this);
						addChild(play);
						break;
					
					case PICK:
						pick = new ScenePick(this);
						addChild(pick);
						break;
					
					case CREDITS:
						credits = new SceneCredits(this);
						addChild(credits);
						break;
				}
			}
		}
	}
}
