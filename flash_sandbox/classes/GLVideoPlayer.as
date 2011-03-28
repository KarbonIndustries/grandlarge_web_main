package classes
{
	import flash.display.*;
	import flash.media.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.*;
	import flash.utils.*;
	import caurina.transitions.*;
	import caurina.transitions.properties.DisplayShortcuts;
	DisplayShortcuts.init();

	public class GLVideoPlayer extends Sprite
	{

		/* ============= */
		/* = CONSTANTS = */
		/* ============= */
		private const VIDEO_WIDTH:Number				= 960;
		private const VIDEO_HEIGHT:Number				= 540;
		private const ASPECT_RATIO:Number				= VIDEO_WIDTH / VIDEO_HEIGHT;
		private const FADE_SPD:Number					= 1;
		private const FADE_TRANS:String					= 'easeOutExpo';
		private const TIMER_DELAY:Number				= 2000;

		/* ========== */
		/* = EVENTS = */
		/* ========== */
		private const TOGGLE_FS:String					= 'toggleFullscreen';
		private const PLAY_PAUSE:String					= 'playPause';
		private const SCRUBBING:String					= 'scrubbing';

		/* ============== */
		/* = PROPERTIES = */
		/* ============== */
		private var vid:Video;
		private var ns:NetStream;
		private var nc:NetConnection;
		private var pb:GLPlayback;
		private var bg:Shape;
		private var data:Object;
		private var index:uint;
		private var isPlaying:Boolean;
		private var _isScrubbing:Boolean;
		private var timer:Timer;

		public function GLVideoPlayer()
		{
			bg = new Shape();
			with(bg.graphics)
			{
				lineStyle();
				beginFill(0x000000);
				drawRect(0,0,VIDEO_WIDTH,VIDEO_HEIGHT);
				endFill();
			}
			addChild(bg);
			init();
		}

		/* =========== */
		/* = METHODS = */
		/* =========== */
		private function init():void
		{
			nc = new NetConnection();
			nc.connect(null);
			ns = new NetStream(nc);
			ns.client = this;
			ns.addEventListener(NetStatusEvent.NET_STATUS,onNetStatus);
			ns.addEventListener(IOErrorEvent.IO_ERROR,ioError);
			vid = new Video(VIDEO_WIDTH,VIDEO_HEIGHT);
			vid.smoothing = true;
			vid.attachNetStream(ns);
			this.addEventListener(MouseEvent.MOUSE_MOVE,mouseMovement);
			addChild(vid);
			pb = new GLPlayback();
			pb.addEventListener(TOGGLE_FS,toggleFs);
			pb.addEventListener(PLAY_PAUSE,togglePlayPause);
			pb.addEventListener(SCRUBBING,scrubbing);
			pb.y = VIDEO_HEIGHT - pb.height;
			pb.alpha = 0;
			pb.visible = false;
			addChild(pb);
			timer = new Timer(TIMER_DELAY,1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,timerEnd);
		}

		override public function set width(n:Number):void
		{
			vid.width = n;
		}

		override public function set height(n:Number):void
		{
			vid.height = n;
		}

		private function mouseMovement(e:Event = null):void
		{
			if(pb.alpha == 0 || pb.visible == false)
			{
				pb.show();
			}
			timer.reset();
			timer.start();
		}

		private function timerEnd(e:Event = null):void
		{
			pb.hide();
		}

		public function hide():void
		{
			Tweener.addTween(this,{_autoAlpha:0,time:FADE_SPD,transition:FADE_TRANS,onComplete:reset});
		}

		public function show():void
		{
			Tweener.addTween(this,{_autoAlpha:1,time:FADE_SPD,transition:FADE_TRANS});
		}

		public function reset():void
		{
			pb.reset();
		}

		private function toggleFs(e:Event):void
		{
			this.dispatchEvent(new Event(TOGGLE_FS));
		}

		public function onMetaData(metadata:Object):void
		{
			data = metadata;
			addEventListener(Event.ENTER_FRAME,updateTimeline);
		}

		private function onNetStatus(e:NetStatusEvent):void
		{
			if(e.info.code == 'NetStream.Play.Stop')
			{
				vid.clear();
				isPlaying = false;
				removeEventListener(Event.ENTER_FRAME,updateTimeline);
				dispatchEvent(new Event(Karbonizer.VIDEO_EVENT.COMPLETE));
			}
		}

		private function ioError(e:IOErrorEvent)
		{
			Karbonizer.echo('io error!');
		}

		public function updateTimeline(e:Event):void
		{
			pb.buffer = ns.bytesLoaded / ns.bytesTotal;
			pb.position = ns.time / data.duration;
		}

		public function get id():uint
		{
			return index;
		}

		public function play(v:String,videoIndex:uint):void
		{
			index = videoIndex;
			vid.clear();
			show();
			Karbonizer.isSet(v) ? ns.play(v) : null;
			isPlaying = true;
			pb.showPause();
		}

		private function pause():void
		{
			removeEventListener(Event.ENTER_FRAME,updateTimeline);
			ns.pause();
			pb.showPlay();
			isPlaying = false;
		}

		private function resume():void
		{
			addEventListener(Event.ENTER_FRAME,updateTimeline);
			ns.resume();
			pb.showPause();
			isPlaying = true;
		}

		public function togglePlayPause(e:Event = null):void
		{
			isPlaying ? pause() : resume();
		}

		private function scrubbing(e:Event = null):void
		{
			_isScrubbing = true;
			pause();
			this.time = e.target.time;
		}

		public function doneScrubbing():void
		{
			_isScrubbing = false;
			pb.doneScrubbing();
			resume();
		}

		public function get time():Number
		{
			return 0;// || playhead;
		}

		public function set time(time):void
		{
			ns.seek(time * data.duration);
		}
		
		public function get aspect():Number
		{
			return ASPECT_RATIO;
		}

		public function get isScrubbing():Boolean
		{
			return _isScrubbing;
		}
	}
}