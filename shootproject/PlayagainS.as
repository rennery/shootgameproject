package  {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	public class PlayagainS extends Sprite{
			public var pctText:TextField;
		 	public var isagain:Boolean;
		public function PlayagainS() {
			
		
			// constructor code
			var tf:TextFormat = new TextFormat("Bradley Hand ITC", 40, 0xFFFFFF, true);
			tf.align = "center";
			pctText = new TextField();
			
			pctText.selectable = false;
			pctText.autoSize = "center";
			pctText.width = 300;
			pctText.defaultTextFormat = tf;
			pctText.x = 500;
			pctText.y = 240;
			pctText.text="";
		}
		
		public function getState(sta:int){
			
			
			}

	}
	
}
