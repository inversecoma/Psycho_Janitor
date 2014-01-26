package custom.scenes
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	
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
			var timeline:TimelineLite = new TimelineLite();
			timeline.insert(TweenLite.to(door1, 1, {x:-door1.width}));
			timeline.insert(TweenLite.to(door2, 1, {x:door2.x + door2.width}));
			return timeline;
		}
		
		private function allowInteraction():void
		{
			
		}
		
		private function setData():void
		{
			
		}
	}
}