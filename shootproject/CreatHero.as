package  {
	import citrus.objects.platformer.awayphysics.Hero;
	import flash.display.Sprite;
	
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.core.State;
	import citrus.objects.platformer.box2d.Coin;
	import citrus.objects.platformer.box2d.Enemy;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.MovingPlatform;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	
	public class CreatHero {
		public static var hero:Hero;
		public function CreatHero() {
			// constructor code
			
		}
		public static function creathero():Hero{
			CreatHero.hero=new Hero("hero",{x:50,y:550,width:80,height:48});
			CreatHero.hero.view=new heroView();
			CreatHero.hero.maxVelocity=5;
			
			return CreatHero.hero;
			}

	}
	
}
