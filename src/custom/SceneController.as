package custom
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	
	import custom.scenes.SceneCredits;
	import custom.scenes.ScenePlay;
	import custom.scenes.SceneIntro;
	import custom.scenes.SceneStart;
	import custom.scenes.SceneStore;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;

	public class SceneController extends Sprite
	{
		public const START:int   = 0;
		public const INTRO:int 	 = 1;
		public const STORE:int 	 = 2;
		public const PLAY:int 	 = 3;
		public const CREDITS:int = 4;
		
		private var intro:SceneIntro;
		private var start:SceneStart;
		private var play:ScenePlay;
		private var store:SceneStore;
		private var credits:SceneCredits;
		
		private var storedScene:Sprite;
		private var face:Image;
		
		private var timeline:TimelineLite;

		public function SceneController()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			face = new Image(Assets.getAtlas(1).getTexture("frontface"));
			face.y = Main.stageHeight;
			face.x = Main.stageWidth/2-face.width/2;
			addChild(face);
			
			nav(null, START);
		}
		
		public function nav(fromScene:Sprite, toScene:int, delay:Number=0):void
		{
			if(fromScene != null)
			{
				storedScene = fromScene;

				face.y = Main.stageHeight;
				timeline = new TimelineLite();
				timeline.append(TweenLite.to(face, .75, {y:Main.stageHeight/2 - face.height/2}));
				timeline.append(TweenLite.to(face, .25, {}));
				timeline.append(TweenLite.delayedCall(0, nav, [null, toScene]));
				timeline.append(TweenLite.to(face, .75, {y:-face.height}));
			}
			else
			{
				if(storedScene!=null && storedScene.parent)
					storedScene.parent.removeChild(storedScene);
				
				switch(toScene)
				{
					case START:
						start = new SceneStart(this);
						addChildAt(start, getChildIndex(face));
						break;
					
					case INTRO:
						intro = new SceneIntro(this);
						addChildAt(intro, getChildIndex(face));
						break;
					
					case STORE:
						store = new SceneStore(this);
						addChildAt(store, getChildIndex(face));
						break;
					
					case PLAY:
						play = new ScenePlay(this);
						addChildAt(play, getChildIndex(face));
						break;
					
					case CREDITS:
						credits = new SceneCredits(this);
						addChildAt(credits, getChildIndex(face));
						break;
					
				}
			}
		}
	}
}