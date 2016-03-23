package  citrus.objects.platformer.box2d{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2Contact;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;

	import citrus.math.MathVector;
	import citrus.objects.Box2DPhysicsObject;
	import citrus.physics.PhysicsCollisionCategories;
	import citrus.physics.box2d.Box2DShapeMaker;
	import citrus.physics.box2d.Box2DUtils;
	import citrus.physics.box2d.IBox2DPhysicsObject;
	import citrus.objects.platformer.box2d.Missile;
	import flash.geom.Point;
	import flash.utils.clearTimeout;
	import flash.utils.getDefinitionByName;
	import flash.utils.setTimeout;
	
	public class Boss extends Enemy{
	public var life:int=2000;
		public function Boss() {
			// constructor code
			super();
		}
	
	override public function handleBeginContact(contact:b2Contact):void {
			
			var collider:IBox2DPhysicsObject = Box2DUtils.CollisionGetOther(this, contact);
			
			if(Box2DUtils.CollisionGetOther(this, contact) is Missile){
				if(life<=0){
				kill=true;
				Enemy.killnum++;
				trace(killnum);}
				else{
					life--;
					}
			}
			if (collider is _enemyClass && collider.body.GetLinearVelocity().y > enemyKillVelocity)
				return;
				
			if (_body.GetLinearVelocity().x < 0 && (contact.GetFixtureA() == _rightSensorFixture || contact.GetFixtureB() == _rightSensorFixture))
				return;
			
			if (_body.GetLinearVelocity().x > 0 && (contact.GetFixtureA() == _leftSensorFixture || contact.GetFixtureB() == _leftSensorFixture))
				return;
			
			if (contact.GetManifold().m_localPoint) {
				
				var normalPoint:Point = new Point(contact.GetManifold().m_localPoint.x, contact.GetManifold().m_localPoint.y);
				var collisionAngle:Number = new MathVector(normalPoint.x, normalPoint.y).angle * 180 / Math.PI;
				
				if ((collider is Platform && collisionAngle != 90) || collider is Enemy)
					turnAround();
			}
				
		}
	}
	
}
