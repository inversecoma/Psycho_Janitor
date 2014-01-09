package custom.scenes
{
	import custom.SceneController;
	
	import starling.display.Sprite;

	public class SceneCredits extends Sprite
	{
		private var sceneController:SceneController;
		
		public function SceneCredits(sceneController:SceneController)
		{
			super();
			
			this.sceneController = sceneController;
		}
	}
}