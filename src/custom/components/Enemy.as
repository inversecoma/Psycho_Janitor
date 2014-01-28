package custom.components
{	
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
		public const CASE:int = 7;
		
		public var fullImage:Image;
		private var brokenImages:Array;
		public var spawned:Boolean = false;
		public var piecesSpawned:Boolean = false;
		public var destroyable:Boolean = false;
		public var damages:Boolean = false;
		public var typeOfEnemy:int;
		public var yPos:int = 400;
		public var speedModifier:int = 1;
		
		public function Enemy(TypeOfEnemy)
		{
			super();
			this.typeOfEnemy = TypeOfEnemy;
			switch(TypeOfEnemy) {
				case VASE:
					fullImage = new Image(Assets.getAtlas().getTexture("vaseFull"));
					var vaseBroken1:Quad = new Image(Assets.getAtlas().getTexture("vaseBroken1"));
					var vaseBroken2:Quad = new Image(Assets.getAtlas().getTexture("vaseBroken2"));
					var vaseBroken3:Quad = new Image(Assets.getAtlas().getTexture("vaseBroken3"));
					var vaseBroken4:Quad = new Image(Assets.getAtlas().getTexture("vaseBroken4"));
					var vaseBroken5:Quad = new Image(Assets.getAtlas().getTexture("vaseBroken5"));
					brokenImages = [vaseBroken1,vaseBroken2,vaseBroken3,vaseBroken4,vaseBroken5];
					destroyable = true;
					this.yPos = 400;
					break;
				case FACE:
					fullImage = new Image(Assets.getAtlas().getTexture("shrubFull"));
					var shrubBroken1:Quad = new Image(Assets.getAtlas().getTexture("shrubBroken1"));
					var shrubBroken2:Quad = new Image(Assets.getAtlas().getTexture("shrubBroken2"));
					var shrubBroken3:Quad = new Image(Assets.getAtlas().getTexture("shrubBroken3"));
					var shrubBroken4:Quad = new Image(Assets.getAtlas().getTexture("shrubBroken4"));
					var shrubBroken5:Quad = new Image(Assets.getAtlas().getTexture("shrubBroken5"));
					brokenImages = [shrubBroken1,shrubBroken2,shrubBroken3,shrubBroken4,shrubBroken5];
					destroyable = true;
					this.yPos = 400;
					break;
				case 2:
					fullImage = new Image(Assets.getAtlas().getTexture("painting1"));
					break;
				case 3:
					fullImage = new Image(Assets.getAtlas().getTexture("painting2"));
					break;
				case 4:
					fullImage = new Image(Assets.getAtlas().getTexture("painting3"));
					break;
				case 5:
					fullImage = new Image(Assets.getAtlas().getTexture("painting4"));
					break;
				case 6:
					fullImage = new Image(Assets.getAtlas().getTexture("kingTut"));
					this.yPos = 220;
					break;
				case 7:
					fullImage = new Image(Assets.getAtlas().getTexture("pedastal"));
					this.yPos = 330;
					break;
				case 8:
					fullImage = new Image(Assets.getAtlas().getTexture("pillar"));
					this.yPos = -20;
					this.speedModifier = 2;
					fullImage.scaleX = fullImage.scaleY = 1.8;
					break;
				case 9:
					fullImage = new Image(Assets.getAtlas().getTexture("sculpture"));
					this.yPos = 208;
					break;
				case 10:
					fullImage = new Image(Assets.getAtlas().getTexture("dress"));
					this.yPos = 300;
					fullImage.scaleX = fullImage.scaleY = 1.5;
					break;
			}
		}
		
		public function update(hero:Hero):void {
			if (spawned) {
				fullImage.x -= hero.speed*speedModifier;
				trace("Enemy x:" + fullImage.x);
			}
			if (fullImage.getBounds(this).intersects(hero.getBounds(this)) && spawned){
				if (hero.isAttacking() && this.destroyable) {
					removeChild(fullImage);
					destroy(fullImage.x,fullImage.y);
				}
				else if (this.damages) {
					hero.loseHealth();
				}
			}
		}
		
		public function move(hero):void {
			if (spawned) {
				if (this.getTypeOfEnemy() == 8) {
					fullImage.x -= hero.speed*speedModifier;
				}
				else {
					fullImage.x -= hero.speed*speedModifier;
				}
				trace("Enemy x:" + fullImage.x);
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
			if (this.typeOfEnemy == 7) {
				fullImage.x += 1080;
			}
			if (this.typeOfEnemy == 10) {
				fullImage.x += 1000 + Math.round(Math.random()*280);
			}
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
		
		public function getTypeOfEnemy():int {
			return this.typeOfEnemy;
		}
		
		public function getYPos():int {
			return this.yPos;
		}
		
	}
}