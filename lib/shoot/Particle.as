package lib.shoot {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Particle extends MovieClip {
		public static const PURGE_EVENT:String = "PURGE";
		public var xVel:Number;
		public var yVel:Number;
		public var airResistance:Number;
		public var gravity:Number;
		
		public function Particle() {
			xVel = 0;
			yVel = 0;
			airResistance = 1;
			gravity = 1;
		}
		
		public function update():void {
			x += xVel;
			y += yVel;
			if (y > 650) {
				dispatchEvent(new Event(Particle.PURGE_EVENT, true, false));
			}
		}
	}
}