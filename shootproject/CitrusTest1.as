package  {
	
	import citrus.core.CitrusEngine;
	import flash.events.MouseEvent;
	import citrus.core.CitrusEngine;
	import citrus.sounds.CitrusSoundGroup;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import citrus.objects.platformer.box2d.Coin;
	import citrus.objects.platformer.box2d.Enemy;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.MovingPlatform;
	import citrus.objects.platformer.box2d.Platform;
	import flash.display.Sprite; 
	import flash.display.Bitmap;


	[SWF(width="1024",height="568",frameRate="60",backgroundColor="#ffffff")]
	public class CitrusTest1 extends CitrusEngine
	{	
		private var bu1:but1;
		private var bu2:but2;
		private var ti:tittle;
		private var intr:Intro;
		private var tuto:tutorial;
		private var bac:backbut;
		private var gs1:GameState;
		private var gs2:GameState2;
		private var pa:PlayagainS;
		private var psb:playAgain;
		private var timer:Timer;
		private var timer2:Timer;
		private var bs:BlackState;
		private var act_but:String;
		private var swfback:Bitmap;
		private var active1:Boolean=false;
		private var active2:Boolean=false;
		
		[Embed(source="assest/back.jpg",mimeType="image/jpg")]
		private var back:Class;
		public function CitrusTest1()
		{
		    swfback = new back(); 
			addChild(swfback); 
			bu1=new but1();
			bs=new BlackState();
			bu2=new but2();
			ti=new tittle();
			intr=new Intro();
			tuto=new tutorial();
			bac=new backbut();
			pa=new PlayagainS();
			psb=new playAgain();
			bu1.addEventListener(MouseEvent.CLICK,activeL1);
			bu2.addEventListener(MouseEvent.CLICK,activeL2);
			tuto.addEventListener(MouseEvent.CLICK,tutoAc);
			bac.addEventListener(MouseEvent.CLICK,backM);
			psb.addEventListener(MouseEvent.CLICK,PlayAg);
			addChild(bu1);
			addChild(bu2);
			addChild(ti);
			addChild(tuto);
			gs1=new GameState();
			gs2=new GameState2();
			timer = new Timer(15);
			timer.addEventListener(TimerEvent.TIMER,monitor);
			
			timer2 = new Timer(25);
			timer2.addEventListener(TimerEvent.TIMER,movebul);
			
			
		}
		private function movebul(e:TimerEvent):void{
			if(act_but=="lv1"){
					if(bu1.x<1024)
						bu1.x+=35;
					else{
						
						removeChild(bu1);
						removeChild(bu2);
						removeChild(ti);
						removeChild(tuto);
						addChild(swfback);
						removeChild(swfback);
						gs1=new GameState();
						state=gs1;
						bu1.x=600;
						timer2.stop();
						timer.start();
						active1=true;
						}
			}
			if(act_but=="lv2"){
					if(bu2.x>0)
					bu2.x-=35;
					else{
						
						removeChild(bu1);
						removeChild(bu2);
						removeChild(ti);
						removeChild(tuto);
						addChild(swfback);
						removeChild(swfback);
						gs2=new GameState2();
						state=gs2;
						timer2.stop();
						timer.start();
						bu2.x=400;
						active2=true;
						}
					
				}
			
			
			
			}
		private function activeL1(e:MouseEvent):void {
			
			act_but="lv1";
			active1=true;
			timer2.start();
			
		}
		private function activeL2(e:MouseEvent):void {
			
			timer2.start();
			active2=true;
			act_but="lv2";
			
			
		}
		private function tutoAc(e:MouseEvent):void{
			removeChild(bu1);
			removeChild(bu2);
			removeChild(ti);
			removeChild(tuto);
			addChild(intr);
			addChild(bac);
				
		}
		private function backM(e:MouseEvent):void{
			addChild(bu1);
			addChild(bu2);
			addChild(ti);
			addChild(tuto);
			removeChild(intr);
			removeChild(bac);
				
		}
		private function PlayAg(e:MouseEvent){
				state=bs;
				removeChild(pa.pctText);
				removeChild(psb);
				addChild(bu1);
				addChild(bu2);
				addChild(ti);
				addChild(tuto);
				//addChild(swfback);
			
			}
		private function monitor(e:TimerEvent){
			trace(GameState.active2.toString());
				if(gs1!=null && GameState.active2==true){
					
					trace("123456");
					trace(active1.toString());
					if(gs1.gameover==1){
						timer.stop();
						pa.pctText.text="Your Hero was killed! Try Again! ";
						addChild(pa.pctText);
						addChild(psb);
						GameState.active2=false;
					}
					if(Enemy.bossiskill==true){
						timer.stop();
						pa.pctText.text="Congratulations! You beat the BOSS!";
						addChild(pa.pctText);
						addChild(psb);
						GameState.active2=false;
						}
				}
				else if(gs2!=null&& GameState2.active2==true ){
					
					trace("123456999999");
					if(gs2.gameover==1){
						timer.stop();
						pa.pctText.text="Your Hero was killed! Try Again! ";
						addChild(pa.pctText);
						addChild(psb);
						GameState2.active2=false;
					}
					if(Enemy.bossiskill==true){
						timer.stop();
						pa.pctText.text="Congratulations! You beat the BOSS!";
						addChild(pa.pctText);
						addChild(psb);
						GameState2.active2=false;
					}
				}
			}
	}
	
}
