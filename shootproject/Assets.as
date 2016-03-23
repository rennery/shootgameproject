package  {
	
	

	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	import flash.display.Bitmap;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	public class Assets
    {
        
        
        private static var sContentScaleFactor:int = 1;
        private static var sTextures:Dictionary = new Dictionary();
        private static var sSounds:Dictionary = new Dictionary();
        private static var sTextureAtlas:TextureAtlas;
        private static var sBitmapFontsLoaded:Boolean;
        
        public static function getTexture(name:String):Texture
        {
            if (sTextures[name] == undefined)
            {
                var data:Object = create(name);
                
                if (data is Bitmap)
                    sTextures[name] = Texture.fromBitmap(data as Bitmap, true, false, sContentScaleFactor);
                else if (data is ByteArray)
                    sTextures[name] = Texture.fromAtfData(data as ByteArray, sContentScaleFactor);
            }
            
            return sTextures[name];
        }
        
        public static function getAtlasTexture(name:String):Texture
        {
            prepareAtlas();
            return sTextureAtlas.getTexture(name);
        }
        
        public static function getAtlasTextures(prefix:String):Vector.<Texture>
        {
            prepareAtlas();
            return sTextureAtlas.getTextures(prefix);
        }

		public static function getTextureAtlas(name:String):TextureAtlas {
			prepareAtlas(name);
			return sTextureAtlas;
		}
        
       
        
        public static function loadBitmapFonts():void
        {
            if (!sBitmapFontsLoaded)
            {
                var texture:Texture = getTexture("DesyrelTexture");
                var xml:XML = XML(create("DesyrelXml"));
                TextField.registerBitmapFont(new BitmapFont(texture, xml));
                sBitmapFontsLoaded = true;
            }
        }
        
       /*
        
        private static function prepareAtlas(name:String = ""):void
        {
			var texture:Texture;
			var xml:XML;
            if (sTextureAtlas == null || name == "")
            {
                texture = getTexture("WorldYellowPng");
                xml = XML(create("WorldYellowConfig"));
                sTextureAtlas = new TextureAtlas(texture, xml);
            }
			else
			{
				texture = getTexture(name + "Png");
                xml = XML(create(name + "Config"));
                sTextureAtlas = new TextureAtlas(texture, xml);
			}
        }*/
        
        private static function create(name:String):Object
        {
            var textureClass:Class = AssetEmbeds1 ;
            return new textureClass[name];
        }
        
        public static function get contentScaleFactor():Number { return sContentScaleFactor; }
        public static function set contentScaleFactor(value:Number):void
        {
            for each (var texture:Texture in sTextures)
                texture.dispose();
            
            sTextures = new Dictionary();
            sContentScaleFactor = value < 1.5 ? 1 : 2; 
        }
    }
}
	

