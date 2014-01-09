package custom.scenes
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	
	import custom.Assets;
	import custom.SceneController;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
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
		
		public function SceneStart(sceneController:SceneController)
		{
			super();
			
			this.sceneController = sceneController;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			background = new Quad(Main.stageWidth, Main.stageHeight, 0xcc66cc);
			addChild(background);
			
			title = new Image(Assets.getAtlas().getTexture("title"));
			addChild(title);
			
			start = new Button(Assets.getAtlas().getTexture("start_default"), "", Assets.getAtlas().getTexture("start_over"));
			addChild(start);
			start.x = Main.stageWidth - start.width;
			start.y = Main.stageHeight - start.height - 38;//OFFSET YOU BITCH
			start.addEventListener(TouchEvent.TOUCH, buttonListener);
			
			TweenLite.from(background, .75, {scaleX:0, scaleY:0});
			
			TweenLite.from(title, 1, {x:-title.width});
			
			TweenLite.from(start, .4, {y:start.y + start.height, delay:.65});
		}
		
		private function animateOut():TimelineLite
		{
			var timeline:TimelineLite = new TimelineLite();
			
			timeline.insert(TweenLite.to(background, .75, {scaleX:0, scaleY:0}));
			timeline.insert(TweenLite.to(title, 1, {x:-title.width}));
			timeline.insert(TweenLite.to(start, .4, {y:start.y + start.height}));
			
			return timeline;
		}
		
		private function buttonListener(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(this);
			
			if(touch.phase == TouchPhase.BEGAN)//on finger down
			{
				trace("down");
			}
			
			if(touch.phase == TouchPhase.ENDED) //on finger up
			{
				trace("up");
				
				sceneController.nav(this, sceneController.PLAY, animateOut().duration());
				
				start.removeEventListener(TouchEvent.TOUCH, buttonListener);
			}
		}
	}
}