package custom.components
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.Color;


	public class Background extends Sprite
	{
		private var background:Quad;
		private var picture1:Quad = new Quad(100,100,0xbf0f0b);
		private var picture2:Quad = new Quad(100,100,0x0066a5);
		private var enemy1:Quad = new Quad(50,50,Color.RED);
		private var jumping:Boolean = false;
		
		public function Background(height,width)
		{
			super();
			this.background = new Quad(width, height, 0xbfff00); 
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
				
		private function onAddedToStage():void
		{
			picture1.x += 500;
			picture1.y += 200;

			picture2.x += 1200;
			picture2.y += 125;

			enemy1.x += 1200;
			enemy1.y += 400;
			
			addChild(background);
			addChild(picture1);
			addChild(picture2);
			addChild(enemy1);
		}
		
		public function update(hero):void
		{
			picture1.x -= hero.speed;
			picture2.x -= hero.speed;
			enemy1.x -= hero.speed;
			
		}
	}
}