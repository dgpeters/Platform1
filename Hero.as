
package 
{

	import flash.display.MovieClip;
	import flash.display.Sprite;
	// import flash.display.Graphics;
	import flash.events.*;// this is needed to listen to events like enterframe.


	public class Hero extends MovieClip
	{
		// declare stuff here.
		private var vx;
		private var vy;
		private var maxvx;
		private var nextx,nexty;

		public var grounded:Boolean;




		public function Hero()
		{
			// constructor code
			// set initial position
			this.x = 200;
			this.y = 40;
			vx = 0;// horizontal speed
			vy = 0;// vertical speed
			maxvx = 3;// max speed
			//hoogte = 0;
			//ray = 0;
			//i=0;
			//jumpstate = false;
			//shootSpeed = 0;
			//shootSpeedMax = 16;
			//firing = 1;

			// Controlling it.
			addEventListener(Event.ENTER_FRAME,moveHero);




		}// end of constructor code

		public function moveHero(event:Event)
		{
			// Determine state (on the ground or not)
			var eenArray = new Array  ;// return array for function hitRay
			var leftArray = new Array  ;// return array for function hitRay
			var rightArray = new Array  ;// return array for function hitRay
			var left = new Number(0);
			var height = new Number(0);
			
			eenArray = MovieClip(parent).hitRay(this.x,this.y,this.x,this.y + 15,MovieClip(parent).dezegrond);
			height = eenArray[2]-this.y;
			
			//trace(eenArray);
			if (eenArray[0] == 1 && height < 2)
			{	
				trace("Hero.as: On the ground");
				if(grounded == false){
				// just landed, set velocities to zero
				grounded = true;
				vy=0;
				vx=0;
				}
				
				
				// when grounded
				// determine angle of ground left of hero
				// misschien hoef je ze niet allebei iederen frame te doen? Om en om opnieuw berekenen?
				//leftArray = MovieClip(parent).hitRay(this.x - 10,this.y - 20,this.x - 10,this.y + 20,MovieClip(parent).dezegrond);
				//trace(eenArray2)
				// determine angle of ground right of here
				//rightArray = MovieClip(parent).hitRay(this.x + 10,this.y - 20,this.x + 10,this.y + 20,MovieClip(parent).dezegrond);
				//trace(rightArray)
				// accellerate left right
				if (MovieClip(parent).leftArrow)
				{
					leftArray = MovieClip(parent).hitRay(this.x - 10,this.y - 20,this.x - 10,this.y + 20,MovieClip(parent).dezegrond);
					vx = (leftArray[1]-this.x)*0.4;
					vy = (leftArray[2]-this.y)*0.4;
					trace(vx, vy)
				}
				if (MovieClip(parent).rightArrow)
				{
					// rechts is nu dominant omdat die als laatste wordt bepaald
					rightArray = MovieClip(parent).hitRay(this.x + 10,this.y - 20,this.x + 10,this.y + 20,MovieClip(parent).dezegrond);
					vx = (rightArray[1]-this.x)*0.4;
					vy = (rightArray[2]-this.y)*0.4;
				}
				if (MovieClip(parent).upArrow)
				{
				
				vy += -12;
				this.y += vy;
				this.x += vx;
				grounded = false;
				}
			// update position from grounded state
			if (grounded){
			this.x += vx;
			this.y += vy;
			vx=0;
			vy=0;
			}
			}// end of if grounded
			
			else{ // hero is not on the ground.
			grounded = false;
			trace("Hero.as: In the air!")
			// accellerate left right
			if (MovieClip(parent).leftArrow)
			{
				vx -=  .5;
			}
			if (MovieClip(parent).rightArrow)
			{
				vx +=  .5;
			}
			if (MovieClip(parent).upArrow)
			{
				//vy -=  1;
			}
			if (MovieClip(parent).downArrow)
			{
				//vy +=  1;
			}
			
			// update position from flying state.
			vx = 0.8 * vx;// beetje afremmen.
			//vy = Math.max((1 * vy + 0.5), 5);
			vy = 0.96 * vy + 0.5;
			// calculate new position
			nextx = this.x + vx;
			nexty = this.y + vy;
			// hittest new position
			// if collission, determine appropriate stopping point
			if (MovieClip(parent).dezegrond.hitTestPoint(nextx,nexty,true))
			{
				trace("Next point collides."+ nextx, nexty);
				//vy = 0;
				this.y +=  0.1*vy;

			}
			else
			{
				trace("no collission");
				this.x +=  vx;
				this.y +=  vy;
			}
			
			}// end of else (if not grounded)
		}// end of moveHero




	}
}