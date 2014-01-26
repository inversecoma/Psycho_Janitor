package custom.scenes
{
	import custom.SceneController;
	
	import starling.display.Quad;
	import starling.display.Sprite;

	public class SceneCredits extends Sprite
	{
		private var sceneController:SceneController;
		
		public function SceneCredits(sceneController:SceneController)
		{
			super();
			var quad:Quad = new Quad(100,100,0xFF0000);
			addChild(quad);
			this.sceneController = sceneController; 
		}
	}
}