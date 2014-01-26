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
					var vaseBroken1:Quad = new Image(Assets.getAtlas().getTexture("vaseBroken1"));
					var vaseBroken2:Quad = new Image(Assets.getAtlas().getTexture("vaseBroken2"));
					var vaseBroken3:Quad = new Image(Assets.getAtlas().getTexture("vaseBroken3"));
					var vaseBroken4:Quad = new Image(Assets.getAtlas().getTexture("vaseBroken4"));
					var vaseBroken5:Quad = new Image(Assets.getAtlas().getTexture("vaseBroken5"));
					brokenImages = [vaseBroken1,vaseBroken2,vaseBroken3,vaseBroken4,vaseBroken5];
					break;
				case FACE:
					fullImage = new Image(Assets.getAtlas().getTexture("shrubFull"));
					var shrubBroken1:Quad = new Image(Assets.getAtlas().getTexture("shrubBroken1"));
					var shrubBroken2:Quad = new Image(Assets.getAtlas().getTexture("shrubBroken2"));
					var shrubBroken3:Quad = new Image(Assets.getAtlas().getTexture("shrubBroken3"));
					var shrubBroken4:Quad = new Image(Assets.getAtlas().getTexture("shrubBroken4"));
					var shrubBroken5:Quad = new Image(Assets.getAtlas().getTexture("shrubBroken5"));
					brokenImages = [shrubBroken1,shrubBroken2,shrubBroken3,shrubBroken4,shrubBroken5];
					break;
				case MACE:
					fullImage = new Image(Assets.getAtlas().getTexture("painting1"));
					break;
				case RACE:
					fullImage = new Image(Assets.getAtlas().getTexture("painting2"));
					break;
				case CHASE:
					fullImage = new Image(Assets.getAtlas().getTexture("painting3"));
					break;
				case PACE:
					fullImage = new Image(Assets.getAtlas().getTexture("painting4"));
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