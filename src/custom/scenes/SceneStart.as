package custom.scenes
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import custom.Assets;
	import custom.SceneController;
	
	import fw.anim.AnimSprite;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.BlurFilter;

	public class SceneStart extends Sprite
	{
		private var sceneController:SceneController;
		
		private var title:Image;
		private var start:Button;
		private var bg:Sprite;
		private var background:Image;
		private var background2:Image;
		
		private var bgTween:TimelineLite;
		private var pressTimeline:TimelineLite
		
		[Embed(source="../../assets/audio/music/baller.mp3")]
		private var Music:Class;
		
		private var music:Sound;
		private var channel:SoundChannel;
		private var transform:SoundTransform;
		
		private var picture1:Image;
		private var picture2:Image;
		private var picture3:Image;
		
		private var foreground1:Image;
		
		private var picAr:Array = [];
		private var forAr:Array = [];
		
		public function SceneStart(sceneController:SceneController)
		{
			super();
			
			this.sceneController = sceneController;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			background = new Image(Assets.getAtlas().getTexture("background"));
			background2 = new Image(Assets.getAtlas().getTexture("background"));
			background2.x = background2.width-1;
			bg = new Sprite();
			bg.addChild(background);
			bg.addChild(background2);
			addChild(bg);
			
			bg.scaleX = bg.scaleY = Main.scale;
			
			picture1 = new Image(Assets.getAtlas().getTexture("painting"+String(Math.ceil(Math.random()*2))));
			picture2 = new Image(Assets.getAtlas().getTexture("painting3"));
			picture3 = new Image(Assets.getAtlas().getTexture("painting4"));
			picAr.push(picture1);
			picAr.push(picture2);
			picAr.push(picture3);
			picture1.x = Math.random() * 400;
			picture2.x = Math.random() * 400 + 400;
			picture3.x = Math.random() * 400 + 800;
			picture1.y = Math.random() * 200+50;
			picture2.y = Math.random() * 200+50;
			picture3.y = Math.random() * 200+50;
			addChild(picture1);
			addChild(picture2);
			addChild(picture3);
			
			title = new Image(Assets.getAtlas().getTexture("title"));
			addChild(title);
			title.x = Main.stageWidth/2 - title.width/2;
			title.y = 75;
			
			var hero:AnimSprite = new AnimSprite(Assets.getAtlas(2));
			
			// Define the sequence: first param is used as a key,  
			// the second is the base texture name in the sprite sheet
			hero.addSequence("walk", "walk cycle_", true, 24);
			Starling.juggler.add(hero); 
			hero.play();
			addChild(hero);
			hero.x = 100;
			hero.y = 275;
			
			
			foreground1 = new Image(Assets.getAtlas().getTexture("pillar"));
			foreground1.x = Main.stageWidth * 2;
			foreground1.y = -75;
			foreground1.filter = new BlurFilter();
			foreground1.scaleX = foreground1.scaleY = 2;
			addChild(foreground1);
			forAr.push(foreground1);
			
			var fadeIn:Quad = new Quad(Main.stageWidth, Main.stageHeight, 0x000000);
			addChild(fadeIn);
			
			TweenLite.to(fadeIn, 1, {alpha:0, delay:.5});
			
			TweenLite.from(title, 1.5, {y:-title.height, delay:.5, ease:Linear.easeNone});//Elastic.easeOut, easeParams:[2,2]
			
			var pressToPlay:Image = new Image(Assets.getAtlas().getTexture("pressToStart"));
			pressToPlay.scaleX = pressToPlay.scaleY = .75 * Main.scale;
			pressToPlay.x = Main.stageWidth/2 - pressToPlay.width/2;
			pressToPlay.y = Main.stageHeight - pressToPlay.height*2 - 38;
			addChild(pressToPlay);
			
			pressTimeline = new TimelineLite();
			pressTimeline.append(TweenLite.to(pressToPlay, 1, {alpha:0}));
			pressTimeline.append(TweenLite.to(pressToPlay, 1, {alpha:1, onComplete:loopPress}));
			
			addEventListener(Event.ENTER_FRAME, loop);
			
			stage.addEventListener(TouchEvent.TOUCH, buttonListener);
			
			music = new Music();
			channel = music.play(0, 99999);
			transform = new SoundTransform(1, 0);
		}
		
		private function loop(e:Event):void
		{
			bg.x--;
			if(bg.x <= -1280)
			{
				bg.x = 0;
			}
			for(var i:int = 0; i < picAr.length; i++)
			{
				picAr[i].x--;
				if(picAr[i].x + picAr[i].width < 0)
				{
					picAr[i].x = Main.stageWidth + Math.random() * 100 - Math.random() * 100;
					picAr[i].y = Math.random() *200 + 50;
				}
			}
			
			for(var i:int = 0; i < forAr.length; i++)
			{
				forAr[i].x-=8;
				if(forAr[i].x + forAr[i].width < 0)
				{
					forAr[i].x = Main.stageWidth * 2;
				}
			}
		}
		
		private function loopPress():void
		{
			pressTimeline.restart();
		}
		
		private function buttonListener(e:TouchEvent):void
		{
			var t:Touch = e.getTouch(this);
			if(t) 
			{
				switch(t.phase) 
				{
					case TouchPhase.BEGAN:
						break;
					
					case TouchPhase.ENDED:
						TweenLite.to(transform, 1, {volume:0, onUpdate:updateTrans, onComplete:stopSound});
						sceneController.nav(this, sceneController.STORE);
						break;
				}
			}
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