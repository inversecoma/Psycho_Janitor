package custom.scenes
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	
	import custom.SceneController;
	import custom.components.Hero;
	
	import starling.display.Sprite;
	import starling.events.Event;

	public class ScenePlay extends Sprite
	{
		private var sceneController:SceneController;
		
		private var speech:Array = ["Hello.", "Welcome to the Global Game Jam test game.", "Look at the source code.", "Press ENTER to begin."];
		
		public function ScenePlay(sceneController:SceneController)
		{
			super();
			
			this.sceneController = sceneController;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			var hero:Hero = new Hero();
			addChild(hero);
			
			hero.x = Main.stageWidth/2 - hero.width/2;
			hero.y = Main.stageHeight/2 - hero.height/2;
			
			TweenLite.from(hero, 1, {y:Main.stageHeight, ease:Elastic.easeOut, easeParams:[2, 1]});
			
			hero.startTalking(speech[1], countWords(speech[1]));
		}
		
		private function countWords(input:String):int
		{
			return input.match(/[^\s]+/g).length;
		}
		
		private function endSpeech(e:Event):void
		{
			
		}
	}
}