package custom.scenes
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.easing.Quad;
	
	import custom.Assets;
	import custom.GlobalData;
	import custom.SceneController;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;

	public class SceneStore extends Sprite
	{
		private var sceneController:SceneController;
		
		private var arm1:Image;
		
		public function SceneStore(sceneController:SceneController)
		{
			super();
			
			this.sceneController = sceneController;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			setData();
			
			createGraphics();
			
			TweenLite.delayedCall(beginningAnimation().duration(), allowInteraction);
		}
		
		private function createGraphics():void
		{
			//var background:Quad = new Quad(
			arm1 = new Image(Assets.getAtlas().getTexture("title"));
			addChild(arm1);
		}
		
		private function beginningAnimation():TimelineLite
		{
			var timeline:TimelineLite = new TimelineLite();
			timeline.append(TweenLite.from(arm1, .5, {x:0, scaleX:1.5, scaleY:1.5}));
			return timeline;
		}
		
		private function allowInteraction():void
		{
			
		}
		
		private function setData():void
		{
			trace(GlobalData.money);
		}
	}
}