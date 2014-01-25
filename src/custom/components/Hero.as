package custom.components
{
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.utils.Timer;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
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
		
		public function Hero()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
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
			
			textField = new TextField(head.width, 25, "");
			textField.hAlign = HAlign.CENTER;
			addChild(textField);
			
			textField.x = 0;
			textField.y = head.y + head.height;
			
			addChild(head);
			addChild(eye1);
			addChild(eye2);
			addChild(textField);
			
			keepTalking = new Timer(100);
		}
		
		public function startTalking(words:String, maxCount:int = 0):void
		{
			this.speechIndex = speechIndex
			this.maxCount = maxCount;
			
			keepTalking.delay = talk();
			keepTalking.addEventListener(TimerEvent.TIMER, talkAgain);
			keepTalking.start();
		}
		
		public function talk():int
		{
			currentSpeech = new this["Say"+Math.ceil(Math.random() * 7)]();
			currentSpeech.play();
			return currentSpeech.length;
		}
		
		public function talkAgain(e:TimerEvent):void
		{
			updateTextField();
			
			count++;
			
			keepTalking.reset();
			
			if(count < maxCount)
			{
				keepTalking.delay = talk();
				keepTalking.start();
			}
			else
			{
				keepTalking.stop();
				dispatchEvent(new Event("doneTalking"));
			}
		}
		
		private function updateTextField():void
		{
			currentWord++;
			
			/////
			// need to purchase club greensock to use something like this...
			/////
			//			var stf:SplitTextField = new SplitTextField(text_tf, SplitTextField.TYPE_WORDS);
			//			var explodeOrigin:Point = new Point(stf.width * 0.4, stf.height + 250);
			//			for (var i:int = stf.textFields.length - 1; i > -1; i--) 
			//			{
			//				var tf:TextField = stf.textFields[i];
			//				var angle:Number = Math.atan2(tf.y - explodeOrigin.y, tf.x - explodeOrigin.x) * 180 / Math.PI;
			//				TweenMax.to(tf, 2, {physics2D:{angle:angle, velocity:Math.random() * 300 + 150, gravity:400}, scaleX:Math.random() * 4 - 2, scaleY:Math.random() * 4 - 2, rotation:Math.random() * 360 - 180, motionBlur:true, autoAlpha:0, delay:Math.random() * 0.5, ease:Quad.easeIn, repeat:1, yoyo:true, repeatDelay:0.7});
			//			}
			
		}
	}
}