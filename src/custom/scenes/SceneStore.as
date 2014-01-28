package custom.scenes
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import custom.Assets;
	import custom.SceneController;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class SceneStore extends Sprite
	{
		private var sceneController:SceneController;
		
		private var background:Image;
		
		private var door1:Image;
		private var door2:Image;
		
		[Embed(source="../../assets/audio/music/another space.mp3")]
		private var Music:Class;
		
		[Embed(source="../../assets/audio/effects/locker.mp3")]
		private var Locker:Class;
		
		private var locker:Sound;
		
		private var music:Sound;
		private var channel:SoundChannel;
		private var transform:SoundTransform;
		
		private var dialogue:Dialogue;
		
		public function SceneStore(sceneController:SceneController)
		{
			super();
			
			this.sceneController = sceneController;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(TouchEvent.TOUCH, touchSelect);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			locker = new Locker();
			
			music = new Music();
			channel = music.play(0, 99999);
			transform = new SoundTransform(1, 0);
			
			TweenLite.delayedCall(1.5, begin);
			
			setData();
			
			createGraphics();
		}
		
		private function touchSelect(e:TouchEvent):void {
			var t:Touch = e.getTouch(this);
			if(t) 
			{
				switch(t.phase) 
				{
					case TouchPhase.BEGAN:
						break;
					
					case TouchPhase.ENDED:
						channel.stop();
						sceneController.nav(this, sceneController.PLAY);
						break;
				}
			}
		}
		
		private function begin():void
		{
			TweenLite.delayedCall(beginningAnimation().duration(), allowInteraction);
		}
		
		private function createGraphics():void
		{
			//var background:Quad = new Quad(
			background = new Image(Assets.getAtlas().getTexture("lockerBG"));
			addChild(background);
		
			door1 = new Image(Assets.getAtlas().getTexture("lockerDoor"));
			addChild(door1);
			
			door2 = new Image(Assets.getAtlas().getTexture("lockerDoor"));
			door2.scaleX = -1;
			door2.x = Main.stageWidth;
			addChild(door2);
		}
		
		private function beginningAnimation():TimelineLite
		{
			locker.play();
			var timeline:TimelineLite = new TimelineLite();
			timeline.insert(TweenLite.to(door1, 1, {x:-door1.width}));
			timeline.insert(TweenLite.to(door2, 1, {x:door2.x + door2.width}));
			return timeline;
		}
		
		private function leave():void
		{
			TweenLite.to(transform, 1, {volume:0, onUpdate:updateTrans, onComplete:stopSound});
		}
		
		private function allowInteraction():void
		{
			stage.addEventListener(TouchEvent.TOUCH, buttonListener);
		}
		
		private function removeDialogue():void
		{
			dialogue.removeEventListener("purchased", removeDialogue);
			TweenLite.to(dialogue, .5, {y:-dialogue.height, onComplete:function():void{removeChild(dialogue)}});
		}
		
		private function buttonListener(e:TouchEvent):void
		{
			var t:Touch = e.getTouch(this);
			if(t) 
			{
				switch(t.phase) 
				{
					case TouchPhase.BEGAN:
						dialogue = new Dialogue();
						dialogue.x = Main.stageWidth/2 - dialogue.width/2;
						dialogue.y = Main.stageHeight;
						addChild(dialogue);
						break;
					
					case TouchPhase.ENDED:
						TweenLite.to(dialogue, .5, {y:Main.stageHeight/2-dialogue.height/2});
						dialogue.addEventListener("purchased", removeDialogue);
						//sceneController.nav(this, sceneController.STORE);
						
						stage.removeEventListener(TouchEvent.TOUCH, buttonListener);
						break;
				}
			}
		}
		
		private function setData():void
		{
			
		}
		
		private function stopSound():void
		{
			channel.stop();
		}
		
		private function updateTrans():void
		{
			channel.soundTransform = transform;
		}
	}
}