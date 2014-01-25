package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	
	import custom.SceneController;
	
	import starling.core.Starling;
	
	public class Main extends Sprite
	{
		public var myStarling:Starling;
		
		public static var stageWidth:int;
		public static var stageHeight:int;
		
		public var viewPort:Rectangle;
		
		public function Main()
		{
			super();
			
			// Some objects are offset down the equivalent of 38 pixels visually. I have no idea why.
			
			stage.frameRate = 60;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT
			
			stageWidth  = stage.fullScreenWidth;
			stageHeight = stage.fullScreenHeight;
			
			viewPort = new Rectangle(0, 0, stageWidth, stageHeight);
			
			myStarling = new Starling(custom.SceneController, stage, viewPort);
			myStarling.start();
		}
	}
}