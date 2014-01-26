package custom.components
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import custom.Assets;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.Color;
	
	public class Hero extends Sprite
	{	
		private var jumping:Boolean = false;
		private var attacking:Boolean = false;
		public var speed:int = 10;
		public var jumpSpeed:int = 4;
		public var yStartPosition:int;
		public var jumpHeight:int = 180;
		public var jumpCount:int = 2;
		public var jumpNum:int = 0;
		public var distance:int = 0;
		public var bullet:Quad = new Quad(10,10, Color.RED);
		public var healths:Array = [new Image(Assets.getAtlas().getTexture("vaseBroken1")),new Image(Assets.getAtlas().getTexture("vaseBroken2")),
			new Image(Assets.getAtlas().getTexture("vaseBroken3")),new Image(Assets.getAtlas().getTexture("vaseBroken4")),
			new Image(Assets.getAtlas().getTexture("vaseBroken3")),new Image(Assets.getAtlas().getTexture("vaseBroken4"))];
		public var healthNum:int = 5;
		public var alive:Boolean = true;
				
		public function Hero()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage():void
		{
			var head:starling.display.Quad = new starling.display.Quad(64, 128, 0xff00cc);
			
			var eye1:starling.display.Quad = new starling.display.Quad(20, 20, 0xffffff);
			eye1.x = head.width - eye1.width/.75;
			eye1.y = eye1.height;
			
			var eye2:starling.display.Quad = new starling.display.Quad(20, 20, 0xffffff);
			eye2.x = eye1.x - eye1.width/.75;
			eye2.y = eye2.height;
			
			var weapon:starling.display.Quad = new starling.display.Quad(100,20,0xffffff);
			
			bullet.x+=100;
			
			addChild(head);
			addChild(eye1);
			addChild(eye2);
			addChild(bullet);
			var i:int = 0;
			for each (var health:Image in healths) {
				health.y+=250;
				health.x+=100*i
				i+=1;
				addChild(health);
			}
		}
		
		public function jump():void {
			if (!jumping) {
				jumping = true;
				TweenLite.delayedCall(addJumpToTimeline().duration(), setJumpFalse);
			}
		}
		public function attack():void {
			if (!attacking) {
				attacking = true;
				TweenLite.delayedCall(addAttackToTimeline().duration(), setAttackFalse);
			}
		}
		public function addJumpToTimeline():TimelineLite
		{
			var timeline:TimelineLite = new TimelineLite();
			timeline.append(TweenLite.to(this, .6, {y:this.y-this.jumpHeight, ease:Linear.easeOut}));
			timeline.append(TweenLite.to(this, .6, {y:this.yStartPosition, ease:Linear.easeIn}));
			return timeline;
		}
		public function addAttackToTimeline():TimelineLite
		{
			var timeline:TimelineLite = new TimelineLite();
			timeline.append(TweenLite.to(bullet, .6, {x:bullet.x+200, ease:Linear.easeOut}));
			timeline.append(TweenLite.to(bullet, .6, {x:bullet.x, ease:Linear.easeIn}));
			return timeline;
		}
		private function setJumpFalse():void {
			jumping = false;
		}
		private function setAttackFalse():void {
			attacking = false;
		}
		
		public function isJumping():Boolean {
			return jumping;
		}
		
		public function isAttacking():Boolean {
			return attacking;
		}
		
		public function update():void {
			distance += speed;
			trace("x: " + bullet.x + ", y: " + bullet.y);
		}
		public function loseHealth():void {
			trace("losing health: " + healthNum);
			removeChild(healths[healthNum]);
			healthNum -= 1;
			if (healthNum < 0) {
				alive = false;
			}
		}
		public function isAlive():Boolean {
			return true;
		}
	}
}