package lib.shoot {
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import lib.shoot.DieAIGame;	
	import flash.media.SoundMixer;
	import flash.ui.Mouse;
	import flash.events.Event;	
	import com.greensock.*;
	import com.greensock.easing.*;
	
	public class DieAIDoc extends MovieClip {
		public function DieAIDoc() {
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			stage.align = StageAlign.TOP_LEFT;
			createStartMenu();		
		}
		
		private function createStartMenu():void {
			var startMenu:StartScreen = new StartScreen();			
			addChild(startMenu);
			startMenu.startButton.addEventListener(MouseEvent.CLICK, startIntroHandler);
		}
		
		private function startIntroHandler(evt:MouseEvent):void {
			removeChild(evt.currentTarget.parent);
			evt.currentTarget.removeEventListener(MouseEvent.CLICK, startIntroHandler);
			if(SoundMixer.areSoundsInaccessible() == false) {
				SoundMixer.stopAll();
			}
			createIntro();
		}		
		
		private function createIntro():void {
			var startIntro:IntroScreen = new IntroScreen();
			addChild(startIntro);
			startIntro.introButton.addEventListener(MouseEvent.CLICK, startGameHandler);
			TweenLite.to(startIntro, 1, {rotation:360, ease:Back.easeInOut});
		}
		
		private function startGameHandler(evt:MouseEvent):void {
			removeChild(evt.currentTarget.parent);
			evt.currentTarget.removeEventListener(MouseEvent.CLICK, startGameHandler);
			if(SoundMixer.areSoundsInaccessible() == false) {
				SoundMixer.stopAll();
			}
			createGame();
		}
		
		private function createGame():void {
			var game:DieAIGame = new DieAIGame();
			addChild(game);
		}		
	}
}