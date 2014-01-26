package custom
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Assets
	{
		private static var gameTextures:Dictionary = new Dictionary();
		private static var gameTextureAtlas:TextureAtlas;
		private static var gameTextureAtlas1:TextureAtlas;
		private static var gameTextureAtlas2:TextureAtlas;
		
		[Embed(source="../assets/atlas.png")]
		public static const AtlasTextureGame:Class;
		[Embed(source="../assets/atlas.xml", mimeType="application/octet-stream")]
		public static const AtlasXMLGame:Class;
		
		[Embed(source="../assets/atlas2.png")]
		public static const AtlasTextureGame1:Class;
		[Embed(source="../assets/atlas2.xml", mimeType="application/octet-stream")]
		public static const AtlasXMLGame1:Class;
		
		[Embed(source="../assets/atlas3.png")]
		public static const AtlasTextureGame2:Class;
		[Embed(source="../assets/atlas3.xml", mimeType="application/octet-stream")]
		public static const AtlasXMLGame2:Class;
		
		public static function getTexture(name:String):Texture
		{
			if(gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
		
		public static function getAtlas(atlas:int = 0):TextureAtlas
		{
			switch(atlas)
			{
				case 0:
					if(gameTextureAtlas == null)
					{
						var texture:Texture = getTexture("AtlasTextureGame");
						var xml:XML = XML(new AtlasXMLGame());
						gameTextureAtlas = new TextureAtlas(texture, xml);
					}
					return gameTextureAtlas;
					break;
				
				case 1:
					if(gameTextureAtlas1 == null)
					{
						var texture:Texture = getTexture("AtlasTextureGame1");
						var xml:XML = XML(new AtlasXMLGame1());
						gameTextureAtlas1 = new TextureAtlas(texture, xml);
					}
					return gameTextureAtlas1;
					break;
				
				case 2:
					if(gameTextureAtlas2 == null)
					{
						var texture:Texture = getTexture("AtlasTextureGame2");
						var xml:XML = XML(new AtlasXMLGame2());
						gameTextureAtlas2 = new TextureAtlas(texture, xml);
					}
					return gameTextureAtlas2;
					break;
			}
			return null;
		}
	}
}