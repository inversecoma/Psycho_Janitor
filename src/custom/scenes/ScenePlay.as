package custom.scenes
{
	import custom.SceneController;
	
	import starling.display.Sprite;
	import starling.events.Event;

	public class ScenePlay extends Sprite
	{
		private var sceneController:SceneController;
		
		public function ScenePlay(sceneController:SceneController)
		{
			super();
			
			this.sceneController = sceneController;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
	}
}