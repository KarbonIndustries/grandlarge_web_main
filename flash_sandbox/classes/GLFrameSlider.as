package classes
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.*;
	import caurina.transitions.*;
	import caurina.transitions.properties.DisplayShortcuts;
	DisplayShortcuts.init();

	public class GLFrameSlider extends Sprite
	{

/* ============= */
/* = CONSTANTS = */
/* ============= */
		private const FRAME_WIDTH:Number			= 960;
		private const FRAME_HEIGHT:Number			= 540;
		private const FRAME_TRANS_SPD:Number		= 1;
		private const FRAME_TRANS:String			= 'linear';
		private const LOCAL_PROXY_URL:String		= 'http://gl.karbon.dnsalias.com/img_proxy.php';
		private const REMOTE_PROXY_URL:String		= 'img_proxy.php';
		private const PROXY_URL:String    	    	= Security.sandboxType == Security.REMOTE ? REMOTE_PROXY_URL : LOCAL_PROXY_URL;

/* ========== */
/* = EVENTS = */
/* ========== */
		private const POSTERS_LOADED:String			= 'postersLoaded';
		private const POSTER_CLICKED:String			= 'posterClicked';

/* ============== */
/* = PROPERTIES = */
/* ============== */
		private var loader:Loader;
		private var req:URLRequest;
		private var reqVars:URLVariables;
		private var frameSet:Array;
		private var totalFrames:uint;
		private var framesLoaded:uint;
		private var frameShell:Sprite;
		private var curFrameIndex:uint;

		public function GLFrameSlider()
		{
			super();
			req = new URLRequest(PROXY_URL);
			req.method = URLRequestMethod.POST;
			reqVars = new URLVariables();
		}

/* =========== */
/* = METHODS = */
/* =========== */
		public function show(imgIndex:uint)
		{
			frameSet[imgIndex].alpha = 0;
			frameSet[imgIndex].visible = false;
			addChild(frameSet[imgIndex]);
			Tweener.addTween(frameSet[imgIndex],{_autoAlpha:1,time:FRAME_TRANS_SPD,transition:FRAME_TRANS});
		}

		public function reset():void
		{
			frameSet[0].alpha = 1;
			frameSet[0].visible = true;
			addChild(frameSet[0]);
		}

		public function load(urlArray:Array)
		{
			totalFrames = urlArray.length;
			frameSet = new Array();
			for(var url:String in urlArray)
			{
				loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,frameLoaded);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,ioError);
				loader.mouseEnabled = false;
				frameShell = new Sprite();
				frameShell.addEventListener(MouseEvent.CLICK,frameClicked);
				frameShell.name = String(url);
				frameShell.buttonMode = true;
				frameShell.addChild(loader);
				frameShell.x = frameShell.y = frameShell.alpha = 0;
				frameShell.visible = false;
				frameSet.push(frameShell);
				reqVars.imgURL = urlArray[url];
				req.data = reqVars;
				//loader.load(req);
				loader.load(new URLRequest(urlArray[url]));
			}
		}
		
		private function frameLoaded(e:Event):void
		{
			framesLoaded++;
			e.target.loader.width != FRAME_WIDTH ? e.target.loader.width = FRAME_WIDTH : null;
			e.target.loader.height != FRAME_HEIGHT ? e.target.loader.height = FRAME_HEIGHT : null;
			framesLoaded == totalFrames ? postersLoaded() : null;
			e.target.loader.parent == frameSet[0] ? show(0) : null;
		}
		
		private function ioError(e:Event):void
		{
			Karbonizer.echo('load error');
		}

		public function get clickedFrameId():uint
		{
			return uint(curFrameIndex);
		}

		private function frameClicked(e:Event):void
		{
			curFrameIndex = uint(e.target.name);
			this.dispatchEvent(new Event(POSTER_CLICKED));
		}
		
		private function postersLoaded():void
		{
			this.dispatchEvent(new Event(POSTERS_LOADED));
		}
	}
}