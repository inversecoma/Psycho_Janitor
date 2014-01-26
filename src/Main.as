package
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
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
		
		public var viewPort:Rectangle;
		
		private var sp:Sprite;
		
		private var trumpet:Sound;
		
		[Embed(source="assets/audio/effects/trumpet.mp3")]
		private var Trumpet:Class;
		
		public function Main()
		{
			super();
			
			// Some objects are offset down the equivalent of 38 pixels visually. I have no idea why.
			
			stage.color = 0x000000;
			stage.frameRate = 60;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT
			
			stageWidth  = stage.fullScreenWidth;
			stageHeight = stage.fullScreenHeight;
			
			var nc:NetConnection = new NetConnection();
			nc.connect(null);
			
			var ns:NetStream = new NetStream(nc);
			
			ns.client={onMetaData:function(obj:Object):void{} }
			var vid:Video = new Video();
			vid.attachNetStream(ns);
			ns.play("assets/video/splash.flv");
			
			sp = new Sprite();
			sp.addChild(vid);
			sp.width = stageWidth;
			sp.height = stageHeight;
			addChild(sp);
			
			trumpet = new Trumpet();
			trumpet.play();
			
			TweenLite.delayedCall(0, startStarling);
		}
		
		private function startStarling():void
		{
			removeChild(sp);
			
			viewPort = new Rectangle(0, 0, stageWidth, stageHeight);
			
			myStarling = new Starling(custom.SceneController, stage, viewPort);
			myStarling.start();
		}
	}
}