package custom.scenes
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	
	import custom.SceneController;
	import custom.components.Background;
	import custom.components.Hero;
	
	import starling.display.Sprite;
	import starling.events.Event;

	public class ScenePlay extends Sprite
	{
		private var sceneController:SceneController;
		private var background:Background = new Background();
		private var hero:Hero = new Hero();
		
		public function ScenePlay(sceneController:SceneController)
		{
			super();
			
			this.sceneController = sceneController;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			trace("on added to stage in scene play");

			addChild(background);
			addChild(hero);
			
			hero.x = Main.stageWidth/3 - hero.width/2;
			hero.y = Main.stageHeight*2/3 - hero.height/2;
			
			var timeline:TimelineLite = new TimelineLite();
			
			timeline.insert(TweenLite.from(hero, 1, {y:Main.stageHeight, ease:Elastic.easeOut, easeParams:[2, 1]}));	
			
		}
		
		public function enterFrame(e:Event):void
		{
			background.update(hero);
		}
		
	}
}