package lib.shoot {
	import flash.display.MovieClip;
	import lib.shoot.Particle;
	import flash.events.Event;	
	
	/**
     * Robot enemy particle – now crash‑safe.
     *  ‑ Adds isDead flag so destroy() is idempotent
     *  ‑ Guards against null healthBar reference (#1009)
     */
    public class Robot extends Particle {
        // — Public stats ------------------------------------------------------
        public var maxHP:int = 30;
        public var currentHP:int = maxHP;
        public var percentHP:Number = currentHP / maxHP;
        public var status:String;

        // — Private state -----------------------------------------------------
        private var sinMeter:Number;
        private var bobValue:Number;
        private var isDead:Boolean = false;           // NEW – prevents double‑destroy

        // — Timeline reference -------------------------------------------------
        public var healthBar:MovieClip;               // set on the Robot’s timeline

        // ---------------------------------------------------------------------
        public function Robot() {
            status    = "OK";
            bobValue  = 0.1;
            sinMeter  = 0;

            xVel = 0;
            yVel = 0;
            airResistance = 1;
            gravity = 0;

            gotoAndStop(1);
        }

        /**
         * Safely shrink the green bar – exits silently if bar is missing.
         */
        public function updateHealthBar():void {
            if (!healthBar || !healthBar.barColor) return;   // guard #1009
            percentHP = currentHP / maxHP;
            healthBar.barColor.scaleX = percentHP;
        }

        /**
         * Called whenever the robot takes damage. Runs only once after death.
         */
        public function destroy():void {
            if (isDead) return;                    // idempotent – avoid double calls

            currentHP -= 10;
            if (currentHP <= 0) {
                currentHP = 0;
                gotoAndStop(3);                    // death frame in your timeline
                gravity = 0.75;                    // let it fall dramatically
                status  = "Dead";
                isDead  = true;

                // If this class ever adds listeners/timers, clean them here.
                // removeEventListener(Event.ENTER_FRAME, onEnterFrame);
            }
            updateHealthBar();
        }

        /**
         * Bobbing motion & basic purge test.
         */
        public override function update():void {
            if (status != "Dead") {
                yVel = Math.sin(sinMeter) * bobValue;
            }
            sinMeter += 0.1;

            super.update();

            // Allow a little “run‑in” off‑screen so left‑spawns aren’t nuked instantly
			if (x < -60 || x > 1060) {          // 60 px buffer on both sides
				dispatchEvent(new Event(Particle.PURGE_EVENT, true, false));
			}
        }
    }
}