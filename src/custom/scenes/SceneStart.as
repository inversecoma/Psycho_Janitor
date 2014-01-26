package custom.scenes
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Linear;
	
	import flash.media.Sound;
	
	import custom.Assets;
	import custom.SceneController;
	
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
		
		public function SceneStart(sceneController:SceneController)
		{
			super();
			
			this.sceneController = sceneController;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			background = new Image(Assets.getAtlas().getTexture("Background"));
			background2 = new Image(Assets.getAtlas().getTexture("Background"));
			background2.x = background2.width-1;
			bg = new Sprite();
			bg.addChild(background);
			bg.addChild(background2);
			addChild(bg);
			
			bg.scaleX = bg.scaleY = Main.scale;
			
			title = new Image(Assets.getAtlas().getTexture("title"));
			addChild(title);
			title.x = Main.stageWidth/2 - title.width/2;
			title.y = 75;
			
			var fadeIn:Quad = new Quad(Main.stageWidth, Main.stageHeight, 0x000000);
			addChild(fadeIn);
			
			TweenLite.to(fadeIn, 1, {alpha:0, delay:.5});
			
			TweenLite.from(title, 1.5, {y:-title.height, delay:.5, ease:Linear.easeNone});//Elastic.easeOut, easeParams:[2,2]
			
			bgTween = new TimelineLite();
			
			bgTween.insert(TweenLite.to(bg, 20, {x:-background.width, ease:Linear.easeNone, onComplete:loopBG}));
			
			var pressToPlay:Image = new Image(Assets.getAtlas().getTexture("pressToStart"));
			pressToPlay.scaleX = pressToPlay.scaleY = .5 * Main.scale;
			pressToPlay.x = Main.stageWidth/2 - pressToPlay.width/2;
			pressToPlay.y = Main.stageHeight - pressToPlay.height*2 - 38;
			addChild(pressToPlay);
			
			pressTimeline = new TimelineLite();
			pressTimeline.append(TweenLite.to(pressToPlay, 1, {alpha:0}));
			pressTimeline.append(TweenLite.to(pressToPlay, 1, {alpha:1, onComplete:loopPress}));
			
			bg.addEventListener(TouchEvent.TOUCH, buttonListener);
		}
		
		private function loopPress():void
		{
			pressTimeline.restart();
		}
		
		private function loopBG():void
		{
			bgTween.restart();
		}
		
		private function animateOut():TimelineLite
		{
			var timeline:TimelineLite = new TimelineLite();
			
			timeline.insert(TweenLite.to(background, .75, {scaleX:0, scaleY:0}), .2);
			timeline.insert(TweenLite.to(title, 1, {x:-title.width}), .2);
			timeline.insert(TweenLite.to(start, .4, {y:start.y + start.height}), .2);
			
			return timeline;
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
						sceneController.nav(this, sceneController.STORE, animateOut().duration());
						
						bg.removeEventListener(TouchEvent.TOUCH, buttonListener);
						break;
				}
			}
		}
	}
}