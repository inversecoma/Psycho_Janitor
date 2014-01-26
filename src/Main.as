package
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	import custom.SceneController;
	
	import starling.core.Starling;
	
	public class Main extends Sprite
	{
		public var myStarling:Starling;
		
		public static var stageWidth:int;
		public static var stageHeight:int;
		public static var scale:Number;
		
		public var viewPort:Rectangle;
		
		private var vid:Video;
		
		private var trumpet:Sound;
		
		[Embed(source="assets/audio/effects/trumpet.mp3")]
		private var Trumpet:Class;
		
		public function Main()
		{
			super();
			
			//stage properties
			stage.color = 0x000000;
			stage.frameRate = 60;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT
			stageWidth  = stage.fullScreenWidth;
			stageHeight = stage.fullScreenHeight;
			
			scale = stageHeight / 720;
			
			addSplashScreen();
			
			TweenLite.delayedCall(4, startStarling);
		}
		
		private function addSplashScreen():void
		{
			var nc:NetConnection = new NetConnection();
			var ns:NetStream;
			vid = new Video();
			var videoFile:File;
			videoFile = File.applicationDirectory;
			videoFile = videoFile.resolvePath('assets/video/splash.flv');
			nc.connect(null);
			ns = new NetStream(nc);
			ns.client = {onMetaData:function(obj:Object):void{} }
			vid.attachNetStream(ns);
			vid.smoothing = true;
			vid.width = 1280 * scale;
			vid.height = 720 * scale;
			vid.x = stageWidth/2 - vid.width/2;
			vid.y = stageHeight/2 - vid.height/2;
			addChild(vid);
			ns.play(videoFile.url);
			
			trumpet = new Trumpet();
			trumpet.play();
		}
		
		private function startStarling():void
		{
			removeChild(vid);
			
			viewPort = new Rectangle(0, 0, stageWidth, stageHeight);
			myStarling = new Starling(custom.SceneController, stage, viewPort);
			myStarling.start();
		}
	}
}