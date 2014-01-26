package custom.scenes
{
	import custom.Assets;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Dialogue extends Sprite
	{
		private var bg:Image;
		private var redX:Button;
		private var purchase:Button;
		
		public function Dialogue()
		{
			super();
			
			bg = new Image(Assets.getAtlas().getTexture("tanbox"));
			redX = new Button(Assets.getAtlas().getTexture("redx"));
			purchase = new Button(Assets.getAtlas().getTexture("purchasebox"));
			
			redX.x = bg.width-200;
			//redX.y = redX.height/2;
			purchase.x = bg.width/2 - purchase.width/2;
			purchase.y = bg.height - purchase.height * 1.5;
			
			addChild(bg);
			addChild(redX);
			addChild(purchase);
			
			purchase.addEventListener(TouchEvent.TOUCH, buttonListener);
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
						dispatchEvent(new Event("purchased"));
						//stage.removeEventListener(TouchEvent.TOUCH, buttonListener);
						break;
				}
			}
		}
	}
}