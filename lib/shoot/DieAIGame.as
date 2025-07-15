package lib.shoot {
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.*;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.text.*;
    import flash.ui.Keyboard;
    import flash.utils.Timer;
    import flash.media.SoundMixer;

    /**
     * Main game controller – stage‑safe and warning‑free.
     * Handles spawning, input, HUD, win/lose flow.
     */
    public class DieAIGame extends MovieClip {
        // ─────────────────────────── Constants / config ────────────────────────────
        private static const STAGE_W:int = 1000;
        private static const STAGE_H:int = 600;
        private static const PLAYER_START_X:int = 500;
        private static const PLAYER_START_Y:int = 355;
        private static const TIMER_START_MIN:int = 2;   // 02:00 countdown

        // ───────────────────────── Runtime flags & state ───────────────────────────
        private var moveLeft:Boolean  = false;
        private var moveRight:Boolean = false;
        private var spaceBar:Boolean  = false;
        private var isGameOver:Boolean = false;
        private var isInited:Boolean   = false;

        // ───────────────────────────── Game objects ────────────────────────────────
        private var player:Player;
        private var lasers:Array = [];
        private var robots:Array = [];

        private var background:Sprite;
        private var lasersLayer:Sprite = new Sprite();
        private var robotsLayer:Sprite = new Sprite();
        private var uiLayer:Sprite     = new Sprite();
        private var touchLayer:Sprite  = new Sprite();
        private var exit:MovieClip;

        // ─────────────────── Difficulty & spawning variables ───────────────────────
        private var robotSpawnDelay:Number   = 400;
        private var robotSpawnCounter:Number = 0;
        private var difficulty:Number        = 1;
        private const DIFFICULTY_RATE:Number = 0.3;

        // ───────────────────────────────── HUD ──────────────────────────────────────
        private var score:uint = 0;
        private var scoreText:TextField;
        private var timerText:TextField;
        private var secs:int = 0;
        private var mins:int = TIMER_START_MIN;
        private var gameTimer:Timer = new Timer(1000);

        // ────────────────────────────── Constructor ────────────────────────────────
        public function DieAIGame() {
            scrollRect = new Rectangle(0, 0, STAGE_W, STAGE_H);
            addEventListener(Event.ADDED_TO_STAGE, init);
        }

        /**
         * Deferred initialisation – avoid #1009 by waiting for stage.
         */
        private function init(e:Event):void {
            if (isInited) return;
            isInited = true;
            removeEventListener(Event.ADDED_TO_STAGE, init);

            buildScene();
            wireEvents();
            gameTimer.start();
        }

        // ───────────────────────────── Scene building ──────────────────────────────
        private function buildScene():void {
            // Background
            background = new LevelOne();
            addChild(background);

            // Gameplay layers (preserve z‑order)
            addChild(lasersLayer);
            addChild(robotsLayer);
            addChild(touchLayer);
            addChild(uiLayer);

            // Player
            player = new Player();
            player.x = PLAYER_START_X;
            player.y = PLAYER_START_Y;
            uiLayer.addChild(player);

            // Exit collider
            exit = new Exit();
            exit.x = 378;
            exit.y = 503;
            uiLayer.addChild(exit);

            // Transparent input plane
            touchLayer.graphics.beginFill(0x0, 0);
            touchLayer.graphics.drawRect(0, 0, STAGE_W, STAGE_H);
            touchLayer.graphics.endFill();

            // HUD
            buildScoreBox();
            buildTimerBox();
        }

        private function wireEvents():void {
            addEventListener(Event.ENTER_FRAME, onEnterFrame);

            stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
            stage.addEventListener(KeyboardEvent.KEY_UP,   handleKeyUp);
            touchLayer.addEventListener(MouseEvent.CLICK,  onMouseShoot);

            gameTimer.addEventListener(TimerEvent.TIMER, onTick);
        }

        // ────────────────────────────────── Input ───────────────────────────────────
        private function handleKeyDown(e:KeyboardEvent):void {
            if (isGameOver) return;
            switch (e.keyCode) {
                case Keyboard.D:     moveRight = true; break;
                case Keyboard.A:     moveLeft  = true; break;
                case Keyboard.SPACE: spaceBar  = true; break;
            }
        }
        private function handleKeyUp(e:KeyboardEvent):void {
            switch (e.keyCode) {
                case Keyboard.D:     moveRight = false; break;
                case Keyboard.A:     moveLeft  = false; break;
                case Keyboard.SPACE: spaceBar  = false; break;
            }
        }
        private function onMouseShoot(e:MouseEvent):void { fireLaser(); }

        // ───────────────────────────────── Lasers ───────────────────────────────────
        private function maybeSpaceShoot():void { if (spaceBar) fireLaser(); }

        private function fireLaser():void {
            if (isGameOver) return;

            var laser:Particle = new MainLaser();
            laser.x = player.x - 35;
            laser.y = player.y;

            var dx:Number = mouseX - player.x;
            var dy:Number = mouseY - player.y;
            var dist:Number = Math.sqrt(dx*dx + dy*dy);
			var power:Number = dist / 15;
			var ang:Number = Math.atan2(dy, dx);

            laser.rotation = ang * 180 / Math.PI;
            laser.xVel = power * Math.cos(ang);
            laser.yVel = power * Math.sin(ang);

            laser.addEventListener(Particle.PURGE_EVENT, onLaserPurge);
            lasersLayer.addChild(laser);
            lasers.push(laser);
        }
        private function onLaserPurge(e:Event):void { purgeLaser(Particle(e.target)); }
        private function purgeLaser(laser:Particle):void {
            laser.removeEventListener(Particle.PURGE_EVENT, onLaserPurge);
            var idx:int = lasers.indexOf(laser);
            if (idx >= 0) lasers.splice(idx, 1);
            if (laser.parent && laser.parent.contains(laser)) laser.parent.removeChild(laser);
        }

        // ───────────────────────────────── Robots ───────────────────────────────────
        private function maybeSpawnRobots():void {
            if (isGameOver) return;
            if (++robotSpawnCounter >= robotSpawnDelay) {
                robotSpawnCounter = 0;
                robotSpawnDelay = Math.max(40, robotSpawnDelay - DIFFICULTY_RATE);
                difficulty += DIFFICULTY_RATE;
                spawnRobotWave();
            }
        }
        private function spawnRobotWave():void {
            var count:int = Math.floor(difficulty);
            for (var i:int = 0; i < count; ++i) {
                spawnRobot(-50, STAGE_H - 110,  Math.random() * difficulty + 1);           // left
                spawnRobot(STAGE_W + 50, STAGE_H - 110, -(Math.random() * difficulty + 1)); // right
            }
        }
        private function spawnRobot(px:Number, py:Number, xv:Number):void {
            var r:Robot = (xv > 0) ? new Robot1() : new Robot2();
            r.x = px; r.y = py; r.xVel = xv;
            r.addEventListener(Particle.PURGE_EVENT, onRobotPurge);
            robotsLayer.addChild(r);
            robots.push(r);
        }
        private function onRobotPurge(e:Event):void { purgeRobot(Particle(e.target)); }
        private function purgeRobot(r:Particle):void {
            r.removeEventListener(Particle.PURGE_EVENT, onRobotPurge);
            var idx:int = robots.indexOf(r);
            if (idx >= 0) robots.splice(idx, 1);
            if (r.parent && r.parent.contains(r)) r.parent.removeChild(r);
        }

        // ─────────────────────── Collision / scoring ────────────────────────
        private function testLaserHits(laser:Particle):void {
            for each (var rob:Robot in robots) {
                if (rob.status != "Dead" && rob.hitTestPoint(laser.x, laser.y, true)) {
                    rob.destroy();
                    score += 10;
                    scoreText.text = "SCORE : " + score;
                    purgeLaser(laser);
                    return;
                }
            }
        }

        // ───────────────────────────── Exit / failure ───────────────────────
        private function checkRobotExit():void {
            for each (var rob:Robot in robots) {
                if (rob.hitTestObject(exit)) { endGame(false); break; }
            }
        }

        // ─────────────────────────────── HUD build ──────────────────────────
        private function buildScoreBox():void {
            var font:DieAIfont = new DieAIfont();
            var fmt:TextFormat = new TextFormat(font.fontName, 30, 0x18CAE6, null, null, null, null, null, TextFormatAlign.CENTER);
            scoreText = new TextField();
            scoreText.defaultTextFormat = fmt; scoreText.embedFonts = true; scoreText.antiAliasType = AntiAliasType.ADVANCED;
            scoreText.width = 200; scoreText.height = 50; scoreText.x = 800; scoreText.y = 10;
            scoreText.text = "SCORE : 00";
            uiLayer.addChild(scoreText);
        }
        private function buildTimerBox():void {
            var font:DieAIfont = new DieAIfont();
            var fmt:TextFormat = new TextFormat(font.fontName, 30, 0x18CAE6, null, null, null, null, null, TextFormatAlign.CENTER);
            timerText = new TextField();
            timerText.defaultTextFormat = fmt; timerText.embedFonts = true; timerText.antiAliasType = AntiAliasType.ADVANCED;
            timerText.width = 200; timerText.height = 50; timerText.x = 20; timerText.y = 10;
            timerText.text = "TIME : " + formatTime(mins, secs);
            uiLayer.addChild(timerText);
        }

        // ───────────────────────────── Timer tick ───────────────────────────
        private function onTick(e:TimerEvent):void {
            if (isGameOver) return;
            if (secs == 0) {
                if (mins == 0) { endGame(true); return; }
                mins--; secs = 59;
            } else {
                secs--;
            }
            timerText.text = "TIME : " + formatTime(mins, secs);
        }
        private function formatTime(m:int, s:int):String {
            var mStr:String = (m < 10) ? "0" + m : String(m);
            var sStr:String = (s < 10) ? "0" + s : String(s);
            return mStr + ":" + sStr;
        }

        // ─────────────────────────── Main game loop ───────────────────────────
        private function onEnterFrame(e:Event):void {
            if (isGameOver) return;

            // Player movement
            const FORWARD_SPEED:Number  = 5.0;
            const BACKWARD_SPEED:Number = 2.0;
            if (moveRight) {
                player.scaleX = -1;
                player.x += FORWARD_SPEED;
            }
            if (moveLeft) {
                player.scaleX = 1;
                player.x -= FORWARD_SPEED;
            }
            screenClampPlayer();
            maybeSpaceShoot();

            // Update lasers / robots
            for each (var l:Particle in lasers) { l.update(); testLaserHits(l); }
            for each (var r:Particle in robots) { r.update(); }

            maybeSpawnRobots();
            checkRobotExit();
        }

        private function screenClampPlayer():void {
            var halfW:Number = player.width * 0.5;
            if (player.x - halfW < 0)            player.x = halfW;
            else if (player.x + halfW > STAGE_W)  player.x = STAGE_W - halfW;
        }

        // ───────────────────────────── Win / Lose ────────────────────────────
        private function endGame(won:Boolean):void {
            if (isGameOver) return;
            isGameOver = true;

            // Stop timers & listeners
            removeEventListener(Event.ENTER_FRAME, onEnterFrame);
            gameTimer.stop();
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
            stage.removeEventListener(KeyboardEvent.KEY_UP,   handleKeyUp);
            touchLayer.removeEventListener(MouseEvent.CLICK, onMouseShoot);

            if (!SoundMixer.areSoundsInaccessible()) SoundMixer.stopAll();

            // Display overlay
            if (won) {
                uiLayer.addChild(new WinGame());
            } else {
                uiLayer.addChild(new GameOver());
            }
        }
    }
}
