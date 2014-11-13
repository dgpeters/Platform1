package 
{

	//import flash.display.MovieClip;
	import flash.events.*;
	import flash.display.*;
	import flash.geom.Point;


	public class platformtest extends MovieClip
	{
		public var thehero:Hero;
		public var leftArrow,rightArrow,spaceBar,upArrow,downArrow:Boolean;
		//public var degrond:grond;

		private var eenArray:Array = new Array  ;// array of drawn stuff
		public var board:Sprite = new Sprite();// displaycontainer for drawn stuff
		var e:Sprite;// temporary index


		public function platformtest()
		{
			// constructor code

			// create hero
			thehero = new Hero();
			addChild(thehero);
			addChild(board);

			// listen for keyboard events
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownFunction);
			stage.addEventListener(KeyboardEvent.KEY_UP,keyUpFunction);
			stage.addEventListener(Event.ENTER_FRAME,showMovement);

			// displaylist uitlezen (nu niet meer in gebruik)
			/*for (var i:int = 0; i<numChildren; i++)
			{
				var e:DisplayObject = getChildAt(i);
				if (e is MovieClip)
				{
					// do stuff with e
					trace(e);
				}
			}*/
			
			// testlijntje van 40 px	
			//board.graphics.lineStyle(1,0x990000,0.5);
			//board.graphics.moveTo(10, 10);
			//board.graphics.lineTo(10, 40);

		}// end of constructor
		
		public function hitRay(x1,y1,x2,y2,hitmc):Array {
			// determine where along given line a collission occurs with hitmc (ground or wall e.g.)
			var returnArray:Array = new Array;
			returnArray[0] = 0; // hit boolean (0: no hit, 1: hit)
			var foundsomething:Boolean =  new Boolean(false);
			var xh, yh:Number;
			xh = x1+0.5*(x2-x1);
			yh = y1+0.5*(y2-y1);
			
			// x1,y1 is het startpunt. x2,y2 het eindpunt.
			// eerst het halfway point testen
			// afhankelijk van in welke helft het zit maak je x1 of x2 gelijk aan xh, het testpunt.
			// und so weiter.
			
			for(var i:int=0; i<6; i++){
				//trace("Testing next point:"+ vector)
				
			
				
				if(hitmc.hitTestPoint(xh,yh,true)){
					// found collission, so the point is closer to x1.
					foundsomething = true;
					x2 = xh;
					y2 = yh;
				}
				else{
					// found no collission, point is close to x2
					x1 = xh;
					y1 = yh;
					}
				xh = x1+0.5*(x2-x1);
				yh = y1+0.5*(y2-y1);
			} // what if it found nothing??
							
				if (foundsomething){
					// highlight ground with an X
					// board.graphics.lineStyle(thickness, color, alpha);
					board.graphics.lineStyle(1,0x990000,0.5);
					board.graphics.moveTo(xh-5, yh-5);
					board.graphics.lineTo(xh+5, yh+5);
					board.graphics.moveTo(xh+5, yh-5);
					board.graphics.lineTo(xh-5, yh+5);
					returnArray = [1, xh, yh];
					//break; // break loop
				}
							
			return(returnArray)
		}// end hitRay

		private function showMovement(event:Event)
		{
			// / this plot the current position of the hero
			// could be used to plot direction of movement/ collission/ etc.

			var position:Sprite = new Sprite();

			board.addChild(position);
			position.graphics.lineStyle(2);
			position.graphics.moveTo(thehero.x-2, thehero.y);
			position.graphics.lineTo(thehero.x+2, thehero.y);
			trace(thehero.x);
			trace(thehero.y);

			eenArray.push(position); // bijhouden zodat weer verwijderd kan worden
			if (eenArray.length > 20)
			{
				e = eenArray.shift();
				//e.graphics.clear();// overbodig
				// shift selecteert en verwijdert element0;
				
				board.removeChild(e);
				trace(board.numChildren);

			}
		}// end of showMovement


		public function keyDownFunction(event:KeyboardEvent)
		{

			if (event.keyCode == 37)
			{
				leftArrow = true;
			}
			else if (event.keyCode == 39)
			{
				rightArrow = true;
			}
			else if (event.keyCode == 38)
			{
				upArrow = true;
			}
			else if (event.keyCode == 40)
			{
				downArrow = true;
			}
			if (event.keyCode == 32)
			{
				spaceBar = true;
			}
		}

		// key lifted
		public function keyUpFunction(event:KeyboardEvent)
		{
			if (event.keyCode == 37)
			{
				leftArrow = false;
			}
			else if (event.keyCode == 39)
			{
				rightArrow = false;
			}
			else if (event.keyCode == 40)
			{
				downArrow = false;
			}
			else if (event.keyCode == 38)
			{
				upArrow = false;
			}
			if (event.keyCode == 32)
			{
				spaceBar = false;
			}
		}

	}
}