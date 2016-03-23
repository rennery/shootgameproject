package
{
  import Box2DAS.Common.V2;
  import Box2DAS.Dynamics.ContactEvent;
  import Box2DAS.Dynamics.b2Body;
  import Box2DAS.Dynamics.b2Fixture;
   
  import com.citrusengine.math.MathVector;
  import com.citrusengine.objects.PhysicsObject;
  import com.citrusengine.objects.platformer.Hero;
  import com.citrusengine.objects.platformer.Missile;
  import com.citrusengine.physics.CollisionCategories;
   
  import flash.display.MovieClip;
  import flash.media.Video;
  import flash.ui.Keyboard;
  import flash.utils.clearTimeout;
  import flash.utils.getDefinitionByName;
  import flash.utils.setTimeout;
   
  import org.osflash.signals.Signal;
   
 
  public class ShootingHero extends Hero
  {
    private var bulletcounter:int=0;
     
    public function ShootingHero(name:String, params:Object = null)
    {
       
      super(name, params)
       
    }
     
    override public function update(time:Number):void
    {
      super.update(time);
       
      var velocity:V2 = _body.GetLinearVelocity();
       
      if (controlsEnabled)
      {
        var moveKeyPressed:Boolean = false;
         
        _ducking = (_ce.input.isDown(Keyboard.S) && _onGround && canDuck);
         
        if (_ce.input.isDown(Keyboard.D) && !_ducking)
        {
          velocity.x += (acceleration);
          moveKeyPressed = true;
        }
         
        if (_ce.input.isDown(Keyboard.A) && !_ducking)
        {
          velocity.x -= (acceleration);
          moveKeyPressed = true;
        }
         
        //If player just started moving the hero this tick.
        if (moveKeyPressed && !_playerMovingHero)
        {
          _playerMovingHero = true;
          _fixture.SetFriction(0); //Take away friction so he can accelerate.
        }
          //Player just stopped moving the hero this tick.
        else if (!moveKeyPressed && _playerMovingHero)
        {
          _playerMovingHero = false;
          _fixture.SetFriction(_friction); //Add friction so that he stops running
        }
         
        if (_onGround && _ce.input.justPressed(Keyboard.SPACE) && !_ducking)
        {
          velocity.y = -jumpHeight;
          onJump.dispatch();
        }
         
        if (_ce.input.isDown(Keyboard.SPACE) && !_onGround && velocity.y < 0)
        {
          velocity.y -= jumpAcceleration;
        }
         
        if (_springOffEnemy != -1)
        {
          if (_ce.input.isDown(Keyboard.SPACE))
            velocity.y = -enemySpringJumpHeight;
          else
            velocity.y = -enemySpringHeight;
          _springOffEnemy = -1;
        }
         
        //Cap velocities
        if (velocity.x > (maxVelocity))
          velocity.x = maxVelocity;
        else if (velocity.x < (-maxVelocity))
          velocity.x = -maxVelocity;
         
        //update physics with new velocity
        _body.SetLinearVelocity(velocity);
         
        //the shooting ability
        if (_ce.input.justPressed())
        {
           
          var bullet:Missile
          if (_inverted) {
            bullet = new Missile("bullet"+bulletcounter, {x:x -width, y:y, width:8, height:3, speed:50, angle:180});
          } else {
            bullet = new Missile("bullet"+bulletcounter, {x:x + width, y:y, width:8, height:3, speed:50, angle:0});
          }
          bulletcounter++
          _ce.state.add(bullet);
 
        }
      }
       
      updateAnimation();
    }
 
  }
}
