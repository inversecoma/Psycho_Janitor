package custom.scenes
{
	import custom.SceneController;
	
	import starling.display.Sprite;

	public class ScenePick extends Sprite
	{
		private var sceneController:SceneController;
		
		public function ScenePick(sceneController:SceneController)
		{
			super();
			
			this.sceneController = sceneController;
		}
	}
}