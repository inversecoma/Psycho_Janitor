package custom.scenes
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	
	import flash.media.Sound;
	
	import custom.Assets;
	import custom.SceneController;
	import custom.components.Background;
	import custom.components.Enemy;
	import custom.components.Hero;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class ScenePlay extends Sprite
	{
		private var sceneController:SceneController;
		private var background:Background = new Background(Main.stageHeight,Main.stageWidth);
		private var hero:Hero = new Hero();
		public var enemies:Array = [new Enemy(0),new Enemy(0),new Enemy(0),new Enemy(0),new Enemy(0),new Enemy(0),new Enemy(0),new Enemy(0),new Enemy(0),new Enemy(0)];
		public var features:Array = [new Enemy(1),new Enemy(2),new Enemy(3),new Enemy(4),new Enemy(5),new Enemy(1),new Enemy(3),new Enemy(1),new Enemy(0),new Enemy(1)];

		public var enemyNum:int = 0;
		public var featureNum:int = 0;
		
		[Embed(source="../../assets/audio/music/pluckd.mp3")]
		private var Music:Class;
		
		private var music:Sound;
		
		public function ScenePlay(sceneController:SceneController)
		{
			super();
			
			this.sceneController = sceneController;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			trace("on added to stage in scene play");

			addChild(background);
			addChild(hero);
			
			hero.x = Main.stageWidth/3 - hero.width/2;
			hero.yStartPosition = Main.stageHeight*2/3 - hero.height/2;
			hero.y = hero.yStartPosition;
			
			var timeline:TimelineLite = new TimelineLite();
			
			timeline.insert(TweenLite.from(hero, 1, {y:Main.stageHeight, ease:Elastic.easeOut, easeParams:[2, 1]}));	
			
			var jump:Button = new Button(Assets.getAtlas().getTexture("start_default"), "", Assets.getAtlas().getTexture("start_over"));
			addChild(jump);
			jump.addEventListener(TouchEvent.TOUCH, jumpListener);
			jump.y = 650;
			jump.x = 1180;
			
			var attack:Button = new Button(Assets.getAtlas().getTexture("start_over"), "", Assets.getAtlas().getTexture("start_default"));
			addChild(attack);
			attack.addEventListener(TouchEvent.TOUCH, attackListener);
			attack.y = 650;
			attack.x = 0;
			
			music = Music();
			music.play();
		}
		
		public function enterFrame(e:Event):void
		{
			background.update(hero);
			hero.update();
			//trace(enemyNum);
			if (hero.distance % 200 == 0) {
				//enemies[enemyNum] = new Enemy(0);
				enemies[enemyNum].fullImage.x = 1300;
				enemies[enemyNum].fullImage.y = 400;
				enemies[enemyNum].spawn();
				addChild(enemies[enemyNum]);
				enemyNum+=1;
				if (enemyNum % 10 == 0) {
					enemyNum = 0;
				}
			}
			if (hero.distance % 1720 == 0 || hero.distance % 1150 == 0) {
				//features[featureNum] = new Enemy(1);
				features[featureNum].fullImage.x = 1300;
				features[featureNum].fullImage.y = 100 + Math.round(Math.random()*100 - Math.random()*100);
				features[featureNum].spawn();
				addChild(features[featureNum]);
				featureNum+=1;
				if (featureNum % 10 == 0) {
					featureNum = 0;
				}
			}
			for each (var enemy in enemies) {
				if (enemy.spawned) {
					enemy.update(hero);
				}
				if (enemy.piecesSpawned) {
					enemy.updatePieces(hero);
				}
				if (enemy.getNumChildren() == 0 && enemy.piecesSpawned) {
					removeChild(enemy);
				}
			}
			for each (var feature in features) {
				if (feature.spawned) {
					feature.move(hero);
				}
				if (feature.piecesSpawned) {
					feature.updatePieces(hero);
				}
				if (feature.getNumChildren() == 0 && feature.piecesSpawned) {
					removeChild(feature);
				}
			}
			trace(hero.isAlive());
			if (!hero.isAlive()) {
				sceneController.nav(this, sceneController.CREDITS);
			}
		}
		
		private function jumpListener(e:TouchEvent):void
		{
			var t:Touch = e.getTouch(this);
			if(t) 
			{
				switch(t.phase) 
				{
					case TouchPhase.BEGAN:
						break;
					
					case TouchPhase.ENDED:
						hero.jump();
						break;
				}
			}
		}
		
		private function attackListener(e:TouchEvent):void
		{
			var t:Touch = e.getTouch(this);
			if(t) 
			{
				switch(t.phase) 
				{
					case TouchPhase.BEGAN:
						break;
					
					case TouchPhase.ENDED:
						hero.attack();
						break;
				}
			}
		}
		
	}
}