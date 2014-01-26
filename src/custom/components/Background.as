package custom.components
{	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;


	public class Background extends Sprite
	{
		private var background:Quad;
		private var picture2:Quad = new Quad(100,100,0x0066a5);
		private var jumping:Boolean = false;
		
		public function Background(height,width) 
		{
			super();
			this.background = new Quad(width, height, 0xbfff00);
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
				
		private function onAddedToStage():void
		{
			
			background.name = "bg";

			picture2.x += 1200;
			picture2.y += 125;
			picture2.name = "picture";			
			
			addChild(background);
			addChild(picture2);
		}
		
		public function update(hero):void
		{
			picture2.x -= hero.speed;
		}
	}
}