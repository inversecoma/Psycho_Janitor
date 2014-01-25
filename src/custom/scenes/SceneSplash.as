package custom.scenes
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	
	import flash.media.Sound;
	
	import custom.SceneController;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;

	public class SceneSplash extends Sprite
	{
		[Embed(source="../../assets/audio/effects/splash.mp3")]
		private var SplashSound:Class;
		
		private var sceneController:SceneController;
		
		private var splashSound:Sound;
		
		public function SceneSplash(sceneController:SceneController)
		{
			super();
			
			this.sceneController = sceneController;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			splashSound = new SplashSound();
			
			animate();
		}
		
		private function animate():void
		{
			//noise!
			splashSound.play();
			
			//container
			var logo:Sprite = new Sprite();
			logo.x = Main.stageWidth/2;
			logo.y = Main.stageHeight/2 - 19; // weird offset shit
			addChild(logo);
			
			//contents of container
			var image:Quad = new Quad(256, 256, 0xff0000);
			image.x = -image.width/2;
			image.y = -image.height/2;
			logo.addChild(image);
			
			var text:TextField = new TextField(image.width, image.height, "FUCK YEAH", "Times New Roman", 28, 0xFFFFFF, true);
			text.x = -text.width/2;
			text.y = -text.height/2
			logo.addChild(text);
			
			//animation
			var timeline:TimelineLite = new TimelineLite();
			timeline.append(TweenLite.from(logo, 1, {scaleX:0, scaleY:0, rotation:6}));
			timeline.append(TweenLite.to(logo, .3, {scaleX:.7, scaleY:1.2}), 1);
			timeline.append(TweenLite.to(logo, .2, {scaleX:2, scaleY:0}));
			
			sceneController.nav(this, sceneController.START, timeline.duration());
		}
	}
}