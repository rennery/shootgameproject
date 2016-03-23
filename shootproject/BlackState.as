package  {
	import citrus.math.MathVector;
	import flash.display.Sprite;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2Contact;
	import citrus.core.starling;
	import citrus.objects.CitrusSprite;
	import citrus.core.State;
	import flash.display.Bitmap;
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
	import flash.display.MovieClip;
	import citrus.utils.objectmakers.ObjectMaker2D;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import feathers.controls.PageIndicator;
	import citrus.objects.platformer.box2d.Missile;
	import citrus.objects.Box2DPhysicsObject;
	import citrus.physics.PhysicsCollisionCategories;
	import citrus.physics.box2d.Box2DShapeMaker;
	import citrus.physics.box2d.Box2DUtils;
	import citrus.physics.box2d.IBox2DPhysicsObject;
	import citrus.objects.platformer.box2d.Boss;
	
	public class BlackState extends State{
	private var swfback:Bitmap;
	
	[Embed(source="assest/back.jpg",mimeType="image/jpg")]
	private var back:Class;
		public function BlackState() {
			// constructor code
			super();
		}
		override public function initialize():void{
			super.initialize();
			array=new Array;
			swfback = new back(); 
			addChild(swfback); 
			var physics:Box2D=new Box2D("box2d");
			
			add(physics);
		}

	}
	
}
