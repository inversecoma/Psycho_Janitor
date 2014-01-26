package custom.scenes
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	
	import custom.SceneController;
	import custom.components.Background;
	import custom.components.Enemy;
	import custom.components.Hero;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class ScenePlay extends Sprite
	{
		private var sceneController:SceneController;
		private var hero:Hero = new Hero();
		public var enemies:Array = [new Enemy(0),new Enemy(1),new Enemy(6),new Enemy(7),new Enemy(8),new Enemy(9),new Enemy(10),new Enemy(0),new Enemy(1),new Enemy(1)];
		public var features:Array = [new Enemy(2),new Enemy(3),new Enemy(4),new Enemy(5),new Enemy(2),new Enemy(3),new Enemy(4),new Enemy(5),new Enemy(2),new Enemy(4)];
		private var background:Background = new Background(Main.stageHeight,Main.stageWidth);
		private var bgTween:TimelineLite;
		
		public var enemyNum:int = 0;
		public var featureNum:int = 0;
		
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
			hero.yStartPosition = Main.stageHeight*2/3 - 100;
			hero.y = hero.yStartPosition;
			
			var timeline:TimelineLite = new TimelineLite();
			
			timeline.insert(TweenLite.from(hero, 1, {y:Main.stageHeight, ease:Elastic.easeOut, easeParams:[2, 1]}));	
			
			stage.addEventListener(TouchEvent.TOUCH, touchListener);
		}
		
		public function enterFrame(e:Event):void
		{
			
			hero.update();
			background.update(hero);
			//trace(enemyNum);
			if (hero.distance % 1500 == 0) {
				//enemies[enemyNum] = new Enemy(0);
				enemies[enemyNum].fullImage.x = Main.stageWidth;
				enemies[enemyNum].fullImage.y = enemies[enemyNum].getYPos();
				enemies[enemyNum].spawn();
				if (enemies[enemyNum].getTypeOfEnemy() == 8){
					addChild(enemies[enemyNum]);
				}
				else {
					addChildAt(enemies[enemyNum], getChildIndex(hero));
				}
				enemyNum+=1;
				if (enemyNum % 10 == 0) {
					enemyNum = 0;
				}
			}
			if (hero.distance % 3000 == 0) {
				//features[featureNum] = new Enemy(1);
				features[featureNum].fullImage.x = Main.stageWidth;
				features[featureNum].fullImage.y = 100 + Math.round(Math.random()*100 - Math.random()*100);
				features[featureNum].spawn();
				addChildAt(features[featureNum], getChildIndex(hero));
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
			if (!hero.isAlive()) {
				sceneController.nav(this, sceneController.CREDITS);
			}
		}
		private function touchListener(e:TouchEvent):void
		{
			var t:Touch = e.getTouch(this);
			if(t) 
			{
				switch(t.phase) 
				{
					case TouchPhase.BEGAN:
						break;
					
					case TouchPhase.ENDED:
						if (t.globalX < Main.stageWidth/2) { 
							hero.attack();
						}
						else {
							hero.jump();
						}
						break;
				}
			}
		}
		
	}
}