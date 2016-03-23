package  {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Score extends Sprite{
		public var pctText:TextField;

		public function Score() {
			// constructor code
			var tf:TextFormat = new TextFormat("Arial, Helvetica", 24, 0xFFFFFF, true);
			tf.align = "center";
			pctText = new TextField();
			
			pctText.selectable = false;
			pctText.autoSize = "center";
			pctText.width = 300;
			pctText.defaultTextFormat = tf;
			pctText.x = 820;
			pctText.y = 40;
			pctText.text="Your Score is";
		}

	}
	
}
