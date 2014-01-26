package custom.components
{
	import flash.media.Sound;
	import flash.utils.Timer;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	
	public class Hero extends Sprite
	{
		[Embed(source="../../assets/audio/dialogue/1.mp3")]
		private var Say1:Class;
		[Embed(source="../../assets/audio/dialogue/2.mp3")]
		private var Say2:Class;
		[Embed(source="../../assets/audio/dialogue/3.mp3")]
		private var Say3:Class;
		[Embed(source="../../assets/audio/dialogue/4.mp3")]
		private var Say4:Class;
		[Embed(source="../../assets/audio/dialogue/5.mp3")]
		private var Say5:Class;
		[Embed(source="../../assets/audio/dialogue/6.mp3")]
		private var Say6:Class;
		[Embed(source="../../assets/audio/dialogue/7.mp3")]
		private var Say7:Class;
		
		private var currentSpeech:Sound;
		private var keepTalking:Timer;
		private var count:int = 0;
		private var maxCount:int = 0;
		private var speechIndex:int = 0;
		private var currentWord:int;
		private var textField:TextField;
		private var jumping:Boolean = false;
		public var speed:int = 2;
		public var jumpSpeed:int = 4;
				
		public function Hero()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(TouchEvent.TOUCH, buttonListener);
		}
		
		private function onAddedToStage():void
		{
			var head:Quad = new Quad(100, 100, 0xff00cc);
			
			var eye1:Quad = new Quad(20, 20, 0xffffff);
			eye1.x = head.width - eye1.width/.75;
			eye1.y = eye1.height;
			
			var eye2:Quad = new Quad(20, 20, 0xffffff);
			eye2.x = eye1.x - eye1.width/.75;
			eye2.y = eye2.height;
			
			addChild(head);
			addChild(eye1);
			addChild(eye2);
		}
		
		public function isJumping():Boolean {
			return jumping;
		}
		
		private function setJumpingFalse():void {
			this.jumping = false;
		}

		private function buttonListener(e:TouchEvent):void
		{
			var t:Touch = e.getTouch(this);
			if(t) 
			{
				switch(t.phase) 
				{
					case TouchPhase.BEGAN:
						jumping = true;
						break;
					
					case TouchPhase.ENDED:
						jumping = false;
						break;
				}
			}
		}
		
	}
}