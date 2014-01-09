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
			
			//Certain objects are visually offset down 38 pixels. I have no idea why. Trace of their y coordinate is equal to stagewidth/2 yet appears offset. WAT?
			
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