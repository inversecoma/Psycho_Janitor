package custom.components
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Hero extends Sprite
	{	
		private var jumping:Boolean = false;
		public var speed:int = 2;
		public var jumpSpeed:int = 4;
		public var yStartPosition:int;
		public var jumpHeight:int = 180;
		public var jumpCount:int = 2;
		public var jumpNum:int = 0;
				
		public function Hero()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage():void
		{
			var head:starling.display.Quad = new starling.display.Quad(100, 100, 0xff00cc);
			
			var eye1:starling.display.Quad = new starling.display.Quad(20, 20, 0xffffff);
			eye1.x = head.width - eye1.width/.75;
			eye1.y = eye1.height;
			
			var eye2:starling.display.Quad = new starling.display.Quad(20, 20, 0xffffff);
			eye2.x = eye1.x - eye1.width/.75;
			eye2.y = eye2.height;
			
			var weapon:starling.display.Quad = new starling.display.Quad(100,20,0xffffff);
			
			addChild(head);
			addChild(eye1);
			addChild(eye2);
		}
		
		public function jump():void {
			if (!jumping) {
				jumping = true;
				TweenLite.delayedCall(addJumpToTimeline().duration(), setJumpFalse);
			}
		}
		public function addJumpToTimeline():TimelineLite
		{
			var timeline:TimelineLite = new TimelineLite();
			timeline.append(TweenLite.to(this, .6, {y:this.y-this.jumpHeight, ease:Linear.easeOut}));
			timeline.append(TweenLite.to(this, .6, {y:this.yStartPosition, ease:Linear.easeIn}));
			return timeline;
		}
		private function setJumpFalse():void {
			if (jumpNum == jumpCount) {
				jumpNum = 0;
			}
			jumping = false;
		}
		
		public function isJumping():Boolean {
			return jumping;
		}
		
	}
}