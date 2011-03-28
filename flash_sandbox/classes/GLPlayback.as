package classes
{
	import flash.display.*;
	import flash.media.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.*;
	import caurina.transitions.*;
	import caurina.transitions.properties.DisplayShortcuts;
	DisplayShortcuts.init();

	public class GLPlayback extends Sprite
	{
		// CONSTANTS
		private const MAX_TIMELINE_WIDTH:Number			= 880;
		private const TIMELINE_HEIGHT:Number			= 4;
		private const TIMELINE_X:Number					= 36;
		private const TIMELINE_Y:Number					= 12;
		private const GL_BLUE:uint						= 0x65A7C0;
		private const WHITE:uint						= 0xFFFFFF;
		private const PLAY_PAUSE_X:Number				= 12;
		private const PLAY_PAUSE_Y:Number				= 7;
		private const FADE_SPD:Number					= 1;
		private const FADE_TRANS:String					= 'easeOutExpo';

		// EVENTS
		private const TOGGLE_FS:String					= 'toggleFullscreen';
		private const PLAY_PAUSE:String					= 'playPause';
		private const SCRUBBING:String					= 'scrubbing';

		// PROPERTIES
		private var bufferBar:Sprite;
		private var timeBar:Sprite;
		private var playBtn:PlayBtn;
		private var pauseBtn:PauseBtn;
		private var scrubPos:Number;

		public function GLPlayback()
		{
			super();
			
			hit.addEventListener(MouseEvent.CLICK,clicked);
			pp.addEventListener(MouseEvent.CLICK,playPause);
			bufferBar = new Sprite();
			bufferBar.addEventListener(MouseEvent.MOUSE_DOWN,bufferDown);
			bufferBar.buttonMode = true;
			//stage.addEventListener(MouseEvent.MOUSE_UP,bufferUp);
			with(bufferBar.graphics)
			{
				lineStyle();
				beginFill(WHITE);
				drawRect(0,0,1,TIMELINE_HEIGHT);
				endFill();
			}
			bufferBar.x = TIMELINE_X;
			bufferBar.y = TIMELINE_Y;
			addChild(bufferBar);
			timeBar = new Sprite();
			timeBar.mouseEnabled = false;
			with(timeBar.graphics)
			{
				lineStyle();
				beginFill(GL_BLUE);
				drawRect(0,0,1,TIMELINE_HEIGHT);
				endFill();
			}
			timeBar.x = TIMELINE_X;
			timeBar.y = TIMELINE_Y;
			addChild(timeBar);
			playBtn = new PlayBtn();
			pauseBtn = new PauseBtn();
			playBtn.x = pauseBtn.x = PLAY_PAUSE_X;
			playBtn.y = pauseBtn.y = PLAY_PAUSE_Y;
			pauseBtn.visible = false;
			addChild(playBtn);
			addChild(pauseBtn);
			addChild(pp);
		}

		// METHODS

		public function hide():void
		{
			Tweener.addTween(this,{_autoAlpha:0,time:FADE_SPD,transition:FADE_TRANS});
		}

		public function show():void
		{
			Karbonizer.echo('show');
			Tweener.addTween(this,{_autoAlpha:1,time:FADE_SPD,transition:FADE_TRANS});
		}

		public function showPlay():void
		{
			playBtn.visible = true;
			pauseBtn.visible = false;
		}

		public function showPause():void
		{
			playBtn.visible = false;
			pauseBtn.visible = true;
		}

		public function reset():void
		{
			bufferBar.width = timeBar.width = 1;
		}

		private function clicked(e:Event):void
		{
			this.dispatchEvent(new Event(TOGGLE_FS));
		}
		
		private function playPause(e:Event):void
		{
			this.dispatchEvent(new Event(PLAY_PAUSE));
		}
		
		public function set position(n:Number):void
		{
			var p:Number = n * MAX_TIMELINE_WIDTH;
			timeBar.width = (p >= 0 && p <= MAX_TIMELINE_WIDTH) ? p : timeBar.width;
		}
		
		public function set buffer(n:Number):void
		{
			var p:Number = n * MAX_TIMELINE_WIDTH;
			bufferBar.width = (p >= 0 && p <= MAX_TIMELINE_WIDTH) ? p : timeBar.width;
		}
		
		private function bufferDown(e:Event):void
		{
			scrubbing();
			this.addEventListener(MouseEvent.MOUSE_MOVE,scrubbing);
		}

		private function scrubbing(e:MouseEvent = null):void
		{
			timeBar.width = this.mouseX - TIMELINE_X;
			timeBar.width = timeBar.width > bufferBar.width ? bufferBar.width : timeBar.width;
			timeBar.width = timeBar.width < 1 ? 1 : timeBar.width;
			scrubPos = timeBar.width / bufferBar.width;
			this.dispatchEvent(new Event(SCRUBBING));
			e ? e.updateAfterEvent() : null;
		}
		
		public function doneScrubbing():void
		{
			try
			{
				this.removeEventListener(MouseEvent.MOUSE_MOVE,scrubbing);
			}catch(e:Error)
			{
				
			}
		}

		public function get time():Number
		{
			return scrubPos;
		}
	}
}

