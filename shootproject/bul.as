package  {
	
	import flash.display.MovieClip;
	
	
	public class bul extends MovieClip {
		
		private var dir:int;
		public function bul() {
			// constructor code
			x=50;
			y=100;
			
		}
		public function positionB(x_set:Number,y_set:Number){
			x=x_set;
			y=y_set;
			}
		public function setDir(d:int){
				dir=d;
			}
		public function MoveF(e:int){
			if(dir==1)
			x+=15;
			else
			x-=15;
		}
	}
	
}
