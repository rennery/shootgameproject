package  {
	import citrus.math.MathVector;
	import flash.display.Sprite;
	import Box2D.Common.Math.b2Vec2;
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
	
	
	
	
	public class GameState2 extends State
	{
		private var array:Array;
		private var enemy1:Enemy;
		private var h:Health;
		private var s:Score;
		
		[Embed(source="assest/monster11.png")]
		private var enemyView1:Class;
		[Embed(source="assest/monster22.png")]
		private var enemyView2:Class;
		[Embed(source="assest/boss.png")]
		private var enemyView3:Class;
		
		
		[Embed(source="assest/hero.png",mimeType="image/png")]
		private var heroView:Class;
		
		[Embed(source="assest/coin.png",mimeType="image/png")]
		private var goalView:Class;
		
		[Embed(source="assest/wall.png",mimeType="image/png")]
		private var platforView:Class;
		[Embed(source="assest/floor1.png",mimeType="image/png")]
		private var platforView1:Class;
		[Embed(source="assest/wall1.png",mimeType="image/png")]
		private var platforView3:Class;
		[Embed(source="assest/movewall1.png",mimeType="image/png")]
		private var platforView4:Class;
		[Embed(source="assest/wall2.png",mimeType="image/png")]
		private var platforView5:Class;
		
		public static var active:Boolean=false;
		public static var active2:Boolean=false;
		private var bulletcounter:int=0;
		public var score:int=0;
		public var gameover:int=0;
		private var b:Missile;
		private var timer:Timer;
		private var hero:Hero;
		private var ae:AssetEmbeds1;
		private var _objectsMC:MovieClip;
		//public var background:CitrusSprite;
		public  var score_g:int;
		public function GameState2()
		{GameState2.active=true;
			score_g=0;
			GameState2.active2=true;
			super();
			Enemy.killnum=0;
		}
		private function getMovie(ee:MovieClip){
			
			}
		override public function initialize():void{
			super.initialize();
			array=new Array;
			
			var physics:Box2D=new Box2D("box2d");
			
			add(physics);
			
			var background:CitrusSprite = new CitrusSprite("Background", {view:AssetEmbeds1, parallax:0.5});
			background.offsetY=0;
			add(background);
			hero=new Hero("hero",{x:50,y:550,width:80,height:48});
			 hero.view=new heroView();
			 hero.maxVelocity=5;
			 hero.hurtTime=2;
			add(hero);
			
			var offset:MathVector = new MathVector(stage.stageWidth/2,stage.stageHeight/2);
			var bounds:Rectangle = new Rectangle(0, 0, 11500, 768);
			var easing:MathVector = new MathVector(0.25, 0.25);
			view.camera.setUp(hero, offset, bounds, easing);
			IniWalls();
			IniEnemy();
			IniCoin();
			
			 
			
			
			
			
			stage.addEventListener(MouseEvent.CLICK,moveEvt);
			timer = new Timer(15);
			timer.addEventListener(TimerEvent.TIMER,Moveball);
			timer.start();
			
			
			h=new Health();
			addChild(h.pctText);
			s=new Score();
			addChild(s.pctText);
			
			
		}
		
		
		
		private function getView(width:Number,height:Number,color:uint):Sprite{
			var view:Sprite=new Sprite();
			view.graphics.beginFill(color);
			view.graphics.drawRect(0, 0, width, height);
			view.graphics.endFill();
			return view;
		}
		
		
		
		private function moveEvt(e:MouseEvent){
			if(GameState2.active==true){
			if(hero.directionH==1)
				b = new Missile("bullet"+bulletcounter, {x:hero.x+50, y:hero.y-20, width:16, height:3, speed:30, angle:0});
			else
				b = new Missile("bullet"+bulletcounter, {x:hero.x-50, y:hero.y-20, width:16, height:3, speed:30, angle:180});
				b.view=getView(16,3,0x00ff00);
				
				trace(bulletcounter);
				bulletcounter++;
				
				add(b);
				var i:int;
				
			}
				
		}
		private function Moveball(e:TimerEvent){
			
				var i:int;
				i=score+Enemy.killnum*50;
				score_g=i;
			h.pctText.text="Your life is:"+(hero.hurtTime);
			s.pctText.text="Your score is:"+i;
			if(hero.hurtTime<=0){
				timer.stop();
				trace("you xi wan le");
				gameover=1;
				hero.kill=true;
				GameState2.active=false;
				}
			if(Enemy.bossiskill==true){
				
				timer.stop();
				hero.kill=true;
				GameState2.active=false;
				}
		}
		
		
		private function IniWalls(){
			var floor:Platform=new Platform("floor",{x:512,y:700,width:31000,height:55});
			floor.view=new platforView();
			
			
			add(floor);
			
			var p1:Platform=new Platform("p1",{x:874,y:151,width:255,height:66});
			p1.view=new platforView1();
			add(p1);
			
			var p3:Platform=new Platform("p3",{x:10,y:480,width:64,height:399});
			p3.view=new platforView3();
			add(p3);
			
			var p5:Platform=new Platform("p5",{x:3,y:480,width:1,height:800});
			p5.view=getView(800,1,0x000000);
			add(p5);
			
			var p4:Platform=new Platform("p4",{x:966,y:380,width:64,height:399});
			p4.view=new platforView3();
			add(p4);
			
			var p2:Platform=new Platform("p2",{x:180,y:550,width:255,height:66});
			p2.oneWay=true;
			p2.view=new platforView1();
			add(p2);
			
			var mp1:MovingPlatform=new MovingPlatform("moviePl",
				{x:400,y:550,width:200,height:48,startX:400,startY:550,endX:630,endY:130});
			mp1.view=new platforView4();
			mp1.touchable=false;
		
			add(mp1);
			
			var mp2:MovingPlatform=new MovingPlatform("movieP2",
				{x:1100,y:550,width:200,height:48,startX:1100,startY:550,endX:1500,endY:550});
			mp2.view=new platforView4();
			mp2.touchable=false;
		
			add(mp2);
			
			var mp3:MovingPlatform=new MovingPlatform("movieP3",
				{x:1100,y:150,width:200,height:48,startX:1100,startY:150,endX:1500,endY:150});
			mp3.view=new platforView4();
			mp3.touchable=false;
		
			add(mp3);
			
			
			var mp4:MovingPlatform=new MovingPlatform("movieP4",
				{x:3100,y:550,width:200,height:48,startX:3100,startY:550,endX:3500,endY:550});
			mp4.view=new platforView4();
			mp4.touchable=false;
		
			add(mp4);
			
			var p51:Platform=new Platform("p51",{x:3500,y:250,width:255,height:66});
			p51.oneWay=true;
			p51.view=new platforView1();
			add(p51);
			
			var p6:Platform=new Platform("p6",{x:1180,y:250,width:255,height:66});
			p6.oneWay=true;
			p6.view=new platforView1();
			add(p6);
			
			var p7:Platform=new Platform("p7",{x:1480,y:450,width:255,height:66});
			p7.oneWay=true;
			p7.view=new platforView1();
			add(p7);
			
			var p8:Platform=new Platform("p8",{x:3280,y:450,width:255,height:66});
			p8.oneWay=true;
			p8.view=new platforView1();
			add(p8);
			
			var p9:Platform=new Platform("p9",{x:1680,y:550,width:255,height:66});
			p9.oneWay=true;
			p9.view=new platforView1();
			add(p9);
			
			var p10:Platform=new Platform("p10",{x:1980,y:490,width:255,height:66});
			p10.oneWay=true;
			p10.view=new platforView1();
			add(p10);
			
			var p11:Platform=new Platform("p11",{x:1870,y:340,width:255,height:66});
			p11.oneWay=true;
			p11.view=new platforView1();
			add(p11);
			
			var p12:Platform=new Platform("p12",{x:2470,y:540,width:255,height:66});
			p12.oneWay=true;
			p12.view=new platforView1();
			add(p12);
			
			var p13:Platform=new Platform("p13",{x:2770,y:540,width:255,height:66});
			p13.oneWay=true;
			p13.view=new platforView1();
			add(p13);
			
			var p14:Platform=new Platform("p14",{x:2770,y:340,width:255,height:66});
			p14.oneWay=true;
			p14.view=new platforView1();
			add(p14);
			
			var p15:Platform=new Platform("p15",{x:3900,y:340,width:255,height:66});
			p15.oneWay=true;
			p15.view=new platforView1();
			add(p15);
			
			var mp5:MovingPlatform=new MovingPlatform("movieP5",
				{x:3100,y:340,width:200,height:48,startX:2570,startY:340,endX:3400,endY:340});
			mp5.view=new platforView4();
			mp5.touchable=false;
		
			add(mp5);
			
			var mp6:MovingPlatform=new MovingPlatform("movieP6",
				{x:4200,y:340,width:200,height:48,startX:4000,startY:340,endX:4500,endY:540});
			mp6.view=new platforView4();
			mp6.touchable=false;
		
			add(mp6);
			
			var p16:Platform=new Platform("p16",{x:4900,y:340,width:255,height:66});
			p16.oneWay=true;
			p16.view=new platforView1();
			add(p16);
			
			var p17:Platform=new Platform("p17",{x:4400,y:240,width:255,height:66});
			p17.oneWay=true;
			p17.view=new platforView1();
			add(p17);
			var p18:Platform=new Platform("p17",{x:4230,y:600,width:20,height:151});
			p18.oneWay=false;
			p18.view=new platforView5();
			add(p18);
			
			var p19:Platform=new Platform("p17",{x:5330,y:600,width:20,height:151});
			p19.oneWay=false;
			p19.view=new platforView5();
			add(p19);
			
		}
		
		private function IniEnemy(){
			
			var enemy:Enemy=new Enemy("enemy",
				{x:900,y:550,width:76,height:76,leftBound:10,rightBound:1000});
			enemy.view=new enemyView1();
			
			add(enemy);
			
			var enemy1:Enemy=new Enemy("enemy1",
				{x:875,y:10,width:76,height:76,leftBound:865,rightBound:900});
			enemy1.view=new enemyView2();
			add(enemy1);
			
			var enemy2:Enemy=new Enemy("enemy2",
				{x:160,y:420,width:76,height:76,leftBound:130,rightBound:280});
			enemy2.view=new enemyView2();
			
			add(enemy2);
			
			var enemy3:Enemy=new Enemy("enemy3",
				{x:960,y:420,width:76,height:76,leftBound:800,rightBound:1300});
			enemy3.view=new enemyView1();
			
			add(enemy3);
			
			
			var enemy4:Enemy=new Enemy("enemy4",
				{x:2260,y:420,width:76,height:76,leftBound:2100,rightBound:2500});
			enemy4.view=new enemyView1();
			
			add(enemy4);
			
			var enemy5:Enemy=new Enemy("enemy5",
				{x:2260,y:420,width:76,height:76,leftBound:2100,rightBound:2500});
			enemy5.view=new enemyView1();
			
			add(enemy5);
			
			var enemy6:Enemy=new Enemy("enemy6",
				{x:1980,y:400,width:76,height:76,leftBound:1900,rightBound:2100});
			enemy6.view=new enemyView1();
			
			add(enemy6);
			
			var enemy7:Enemy=new Enemy("enemy7",
				{x:1680,y:500,width:76,height:76,leftBound:1660,rightBound:1780});
			enemy7.view=new enemyView1();
			
			add(enemy7);
			
			var enemy8:Enemy=new Enemy("enemy8",
				{x:1880,y:300,width:76,height:76,leftBound:1860,rightBound:1980});
			enemy8.view=new enemyView2();
			
			add(enemy8);
			
			var enemy9:Enemy=new Enemy("enemy9",
				{x:1666,y:300,width:76,height:76,leftBound:1650,rightBound:1700});
			enemy9.view=new enemyView2();
			
			add(enemy9);
			
			var enemy10:Enemy=new Enemy("enemy10",
				{x:3900,y:300,width:76,height:76,leftBound:3800,rightBound:4000});
			enemy10.view=new enemyView2();
			
			add(enemy10);
			
			var enemy11:Enemy=new Enemy("enemy11",
				{x:2770,y:300,width:76,height:76,leftBound:2690,rightBound:2800});
			enemy11.view=new enemyView2();
			
			add(enemy11);
			
			var enemy12:Enemy=new Enemy("enemy12",
				{x:2470,y:400,width:76,height:76,leftBound:2400,rightBound:2570});
			enemy12.view=new enemyView2();
			
			add(enemy12);
			
			var enemy13:Enemy=new Enemy("enemy13",
				{x:4470,y:400,width:140,height:176,leftBound:4200,rightBound:5270});
			enemy13.view=new enemyView3();
			enemy13.isboss=true;
			enemy13.speed=5;
			add(enemy13);
			Enemy.bossiskill=false;
			enemy.speed=3;
			enemy1.speed=3;
			enemy2.speed=3;
			enemy3.speed=3;
			enemy4.speed=3;
			enemy5.speed=3;
			enemy6.speed=3;
			enemy7.speed=3;
			enemy8.speed=3;
			enemy9.speed=3;
			enemy10.speed=3;
			enemy11.speed=3;
			enemy12.speed=3;
		}
		
		private function IniCoin(){
			var goal:Coin=new Coin("ring",{x:967,y:80,width:64,height:64});
			goal.view=new goalView;
			goal.onBeginContact.add(function(c:b2Contact):void{
 				if( Box2DUtils.CollisionGetOther(goal, c) is Hero)
				score+=100;
			});
			add(goal);
			var goal1:Coin=new Coin("ring1",{x:660,y:300,width:64,height:64});
			goal1.view=new goalView;
			goal1.onBeginContact.add(function(c:b2Contact):void{
				if( Box2DUtils.CollisionGetOther(goal1, c) is Hero)
				score+=100;
			});
			add(goal1);
			
			var goal2:Coin=new Coin("ring2",{x:1200,y:300,width:64,height:64});
			goal2.view=new goalView;
			goal2.onBeginContact.add(function(c:b2Contact):void{
				if( Box2DUtils.CollisionGetOther(goal2, c) is Hero)
				score+=100;
			});
			add(goal2);
			
			var goal3:Coin=new Coin("ring3",{x:990,y:500,width:64,height:64});
			goal3.view=new goalView;
			goal3.onBeginContact.add(function(c:b2Contact):void{
				if( Box2DUtils.CollisionGetOther(goal3, c) is Hero)
				score+=100;
			});
			add(goal3);
			
			var goal4:Coin=new Coin("ring4",{x:1600,y:200,width:64,height:64});
			goal4.view=new goalView;
			goal4.onBeginContact.add(function(c:b2Contact):void{
				if( Box2DUtils.CollisionGetOther(goal4, c) is Hero)
				score+=100;
			});
			add(goal4);
			
			var goal5:Coin=new Coin("ring5",{x:2100,y:150,width:64,height:64});
			goal5.view=new goalView;
			goal5.onBeginContact.add(function(c:b2Contact):void{
				if( Box2DUtils.CollisionGetOther(goal5, c) is Hero)
				score+=100;
			});
			add(goal5);
			
			var goal6:Coin=new Coin("ring6",{x:1700,y:350,width:64,height:64});
			goal6.view=new goalView;
			goal6.onBeginContact.add(function(c:b2Contact):void{
				if( Box2DUtils.CollisionGetOther(goal6, c) is Hero)
				score+=100;
			});
			add(goal6);
			
			var goal7:Coin=new Coin("ring7",{x:2300,y:300,width:64,height:64});
			goal7.view=new goalView;
			goal7.onBeginContact.add(function(c:b2Contact):void{
				if( Box2DUtils.CollisionGetOther(goal7, c) is Hero)
				score+=100;
			});
			add(goal7);
			
			var goal8:Coin=new Coin("ring8",{x:2700,y:400,width:64,height:64});
			goal8.view=new goalView;
			goal8.onBeginContact.add(function(c:b2Contact):void{
				if( Box2DUtils.CollisionGetOther(goal8, c) is Hero)
				score+=100;
			});
			add(goal8);
			
			var goal9:Coin=new Coin("ring9",{x:1500,y:300,width:64,height:64});
			goal9.view=new goalView;
			goal9.onBeginContact.add(function(c:b2Contact):void{
				if( Box2DUtils.CollisionGetOther(goal9, c) is Hero)
				score+=100;
			});
			add(goal9);
			
			var goal10:Coin=new Coin("ring10",{x:2200,y:500,width:64,height:64});
			goal10.view=new goalView;
			goal10.onBeginContact.add(function(c:b2Contact):void{
				if( Box2DUtils.CollisionGetOther(goal10, c) is Hero)
				score+=100;
			});
			add(goal10);
			
			var goalfinal:Coin=new Coin("ringf",{x:2200,y:500,width:64,height:64});
			goalfinal.view=new goalView;
			goalfinal.onBeginContact.add(function(c:b2Contact):void{
				if( Box2DUtils.CollisionGetOther(goal10, c) is Hero)
				score+=100;
			});
			add(goalfinal);
		}
	
	
	
}
}