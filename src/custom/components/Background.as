package custom.components
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.Color;


	public class Background extends Sprite
	{
		private var background:Quad = new Quad(1000, 450, 0xbfff00);
		private var picture1:Quad = new Quad(100,100,0xbf0f0b);
		private var picture2:Quad = new Quad(100,100,0x0066a5);
		private var enemy1:Quad = new Quad(50,50,Color.RED);
		private var jumping:Boolean = false;
		
		public function Background()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage():void
		{
			trace("On added to stage background");
			addChild(background);
			addChild(picture1);
			picture1.x += 500;
			trace("picture.x in position " + picture1.x);
			picture1.y += 200;
			addChild(picture2);
			picture2.x += 1200;
			picture2.y += 125;
			addChild(enemy1);
			enemy1.x += 1200;
			enemy1.y += 400;
		}
		
		private function canGoLower():Boolean {
			if (picture1.y > 200) {
				return true;
			}
			else {
				return false;
			}
		}
		
		public function update(hero):void
		{
			picture1.x -= hero.speed;
			picture2.x -= hero.speed;
			enemy1.x -= hero.speed;
			trace("jumping: " + hero.isJumping() + ", can go lower: " + canGoLower());
			trace("y: " + picture1.y);
			if (hero.isJumping()) {
				picture1.y += hero.jumpSpeed;
				picture2.y += hero.jumpSpeed; 
				enemy1.y += hero.jumpSpeed;
			}
			else if (!hero.isJumping() && canGoLower()) {
				picture1.y -= hero.jumpSpeed;
				picture2.y -= hero.jumpSpeed; 
				enemy1.y -= hero.jumpSpeed;
			}
		}
	}
}