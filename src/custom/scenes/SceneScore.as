package custom.scenes
{
	import custom.SceneController;
	
	import starling.display.Sprite;

	public class SceneScore extends Sprite
	{
		private var sceneController:SceneController;
		
		public function SceneScore(sceneController:SceneController)
		{
			super();
			
			this.sceneController = sceneController;
		}
	}
}