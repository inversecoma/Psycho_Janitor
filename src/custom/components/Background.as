package custom.components
{	
	import custom.Assets;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;


	public class Background extends Sprite
	{
		private var background:Quad;
		private var background2:Quad;

		private var jumping:Boolean = false;
		
		public function Background(height,width) 
		{
			super();
			this.background = new Quad(width, height);
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
				
		private function onAddedToStage():void
		{
			
			background = new Image(Assets.getAtlas().getTexture("background"));
			background2 = new Image(Assets.getAtlas().getTexture("background"));
			background2.x += background.width;
			addChild(background);
			addChild(background2);
		}
		
		public function update(hero):void
		{
			background.x -= hero.speed;
			background2.x -= hero.speed;
			trace("x1: " + background.x);
			trace("x2: " + background2.x);
			if (background.x < -background.width) {
				background.x += background.width*2
			}
			if (background2.x < -background.width) {
				background2.x += background2.width*2
			}
		}
	}
}