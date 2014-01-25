package custom.scenes
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	
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

	public class SceneStart extends Sprite
	{
		private var sceneController:SceneController;
		
		private var title:Image;
		private var start:Button;
		private var background:Quad;
		
		private var woosh1:Sound;
		private var woosh2:Sound;
		
		[Embed(source="../../assets/audio/effects/swoosh.mp3")]
		private var Woosh:Class;
		
		[Embed(source="../../assets/audio/effects/swoosh2.mp3")]
		private var Woosh2:Class;
		
		public function SceneStart(sceneController:SceneController)
		{
			super();
			
			this.sceneController = sceneController;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			woosh1 = new Woosh();
			woosh2 = new Woosh2();
			
			background = new Quad(Main.stageWidth, Main.stageHeight, 0xcc66cc);
			addChild(background);
			
			title = new Image(Assets.getAtlas().getTexture("title"));
			addChild(title);
			
			start = new Button(Assets.getAtlas().getTexture("start_default"), "", Assets.getAtlas().getTexture("start_over"));
			addChild(start);
			start.x = Main.stageWidth - start.width;
			start.y = Main.stageHeight - start.height - 38;//OFFSET YOU BITCH
			start.addEventListener(TouchEvent.TOUCH, buttonListener);
			
			woosh2.play();
			
			TweenLite.from(background, .75, {scaleX:0, scaleY:0});
			
			TweenLite.from(title, 1, {x:-title.width});
			
			TweenLite.from(start, .4, {y:start.y + start.height, delay:.65});
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
						woosh1.play();
						
						sceneController.nav(this, sceneController.PLAY, animateOut().duration());
						
						start.removeEventListener(TouchEvent.TOUCH, buttonListener);
						break;
				}
			}
		}
	}
}