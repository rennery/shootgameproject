package  {
	import flash.display.Sprite;
	
	import Box2D.Dynamics.Contacts.b2Contact;
	import citrus.core.starling;
	import citrus.objects.CitrusSprite;
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
	import starling.display.Image;
	public class BackgroundSet {
		var background:CitrusSprite;
	

		public function BackgroundSet() {
			// constructor code
			background = new CitrusSprite("background", { view:Image.fromBitmap(new Assets.bg()) , parallax:0.2 } );
			background.view.pivotX = background.x = background.view.width/2;
			background.view.pivotY = background.y = background.view.height / 2;
			background.y += 250;
			background.view.scaleX =background.view.scaleY = 2;
		}

	}
	
}
