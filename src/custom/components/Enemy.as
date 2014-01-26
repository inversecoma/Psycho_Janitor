package custom.components
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import custom.Assets;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class Enemy extends Sprite
	{			
		public const VASE:int = 0;
		public const FACE:int = 1;
		public const MACE:int = 2;
		public const RACE:int = 3;
		public const CHASE:int = 4;
		public const PACE:int = 5;
		public const LACE:int = 6;
		
		public var fullImage:Image;
		private var brokenImages:Array;
		public var spawned:Boolean = false;
		public var piecesSpawned:Boolean = false;
		
		public function Enemy(TypeOfEnemy)
		{
			super();
			switch(TypeOfEnemy) {
				case VASE:
					fullImage = new Image(Assets.getAtlas().getTexture("vaseFull"));
					trace("x: " + x + ", y: " + y);
					var vaseBroken1:Quad = new Image(Assets.getAtlas().getTexture("vaseBroken1"));
					var vaseBroken2:Quad = new Image(Assets.getAtlas().getTexture("vaseBroken2"));
					var vaseBroken3:Quad = new Image(Assets.getAtlas().getTexture("vaseBroken3"));
					var vaseBroken4:Quad = new Image(Assets.getAtlas().getTexture("vaseBroken4"));
					var vaseBroken5:Quad = new Image(Assets.getAtlas().getTexture("vaseBroken5"));
					brokenImages = [vaseBroken1,vaseBroken2,vaseBroken3,vaseBroken4,vaseBroken5];
					break;
				case FACE:
					fullImage = new Image(Assets.getAtlas().getTexture("vaseBroken1"));
					break;
				case MACE:
					fullImage = new Image(Assets.getAtlas().getTexture("vaseBroken2"));
					break;
				case RACE:
					fullImage = new Image(Assets.getAtlas().getTexture("vaseBroken3"));
					break;
				case CHASE:
					fullImage = new Image(Assets.getAtlas().getTexture("vaseBroken4"));
					break;
				case PACE:
					fullImage = new Image(Assets.getAtlas().getTexture("vaseBroken1"));
					break;
				case LACE:
					fullImage = new Image(Assets.getAtlas().getTexture("vaseBroken3"));
					break;
			}
		}
		
		public function update(hero:Hero):void {
			if (spawned) {
				fullImage.x -= hero.speed;
			}
			if (fullImage.getBounds(this).intersects(hero.getBounds(this)) && spawned){
				if (hero.isAttacking()) {
					removeChild(fullImage);
					destroy(fullImage.x,fullImage.y);
				}
				else {
					hero.loseHealth();
				}
			}
		}
		
		public function move(hero):void {
			if (spawned) {
				fullImage.x -= hero.speed;
			}
		}
		
		public function updatePieces(hero):void {
			if(piecesSpawned) {
				for each (var piece in brokenImages) {
					piece.y += Math.random()*50;
					piece.x += Math.round(Math.random()*100 - Math.random()*100)
					if (piece.y > 720) {
						removeChild(piece);
					}
				}
			}
		}
		
		public function spawn():void {
			trace("spawnin!");
			spawned = true;
			addChild(fullImage);
		}
		
		public function destroy(x,y):void {
			spawned = false;
			piecesSpawned = true;
			for each (var piece in brokenImages) {
				piece.x = x + Math.round(Math.random()*100 - Math.random()*100);
				piece.y = y + Math.round(Math.random()*50 - Math.random()*50);
				addChild(piece);
			}
		}
		
		public function getNumChildren():int {
			return numChildren;
		}
		
	}
}