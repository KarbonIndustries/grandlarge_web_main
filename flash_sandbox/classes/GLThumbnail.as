package classes
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import caurina.transitions.*;
	import caurina.transitions.properties.DisplayShortcuts;
	DisplayShortcuts.init();

	public class GLThumbnail extends Sprite
	{
/* ==================== */
/* = LOADER CONSTANTS = */
/* ==================== */
		private const THUMB_WIDTH:uint				= 192;
		private const THUMB_HEIGHT:uint				= 108;
		private const GL_BLUE:uint					= 0x65A7C0;
		private const TIME_BAR_HEIGHT:Number		= 4;

/* ========== */
/* = EVENTS = */
/* ========== */
		private const THUMB_LOADED:String			= 'thumbLoaded';
		private const SLIDE_COMPLETE:String			= 'slideComplete';

/* =================== */
/* = TWEEN CONSTANTS = */
/* =================== */
		private const LDR_FADE_SPD:Number			= 1;
		private const LDR_FADE_TRANS:String			= 'easeOutExpo';
		private const SLIDE_LENGTH:Number			= 3;
		private const TIME_BAR_TRANS:String			= 'linear';
		private const TIME_BAR_FADE_SPD:Number		= 1;
		private const TIME_BAR_FADE_DELAY:Number	= 1;
		//private const TIME_BAR_FADE_TRANS:String	= ''

/* ============== */
/* = PROPERTIES = */
/* ============== */
		private var loader:Loader;
		private var hit:Sprite;
		private var thumbID:uint;
		private var timeBar:Shape;

		public function GLThumbnail(img:String,_id:uint)
		{
			super();
			thumbID = _id;
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loaded);
			loader.load(new URLRequest(img));
			timeBar = new Shape();
			with(timeBar.graphics)
			{
				lineStyle();
				beginFill(GL_BLUE);
				drawRect(0,0,1,TIME_BAR_HEIGHT);
				endFill();
			}
			timeBar.x = -1;
			timeBar.alpha = 0;
			timeBar.y = THUMB_HEIGHT - TIME_BAR_HEIGHT;
			hit = new Sprite();
			hit.buttonMode = true;
			with(hit.graphics)
			{
				lineStyle();
				beginFill(0xFF0000,0);
				drawRect(0,0,THUMB_WIDTH,THUMB_HEIGHT);
				endFill();
			}
		}

/* =========== */
/* = METHODS = */
/* =========== */		
		private function loaded(e:Event):void
		{
			this.dispatchEvent(new Event(THUMB_LOADED));
			var img = e.target.loader;
			//Bitmap(img.content).smoothing = true;
			img.width = THUMB_WIDTH;
			img.height = THUMB_HEIGHT;
			img.alpha = 0;
			addChild(img);
			addChild(timeBar);
			addChild(hit);
			Tweener.addTween(img,{alpha:1,time:LDR_FADE_SPD,transition:LDR_FADE_TRANS});
		}

		public function start():void
		{
			Tweener.addTween(timeBar,{_autoAlpha:1,time:.1,transition:TIME_BAR_TRANS});
			Tweener.addTween(timeBar,
			{
				width:THUMB_WIDTH + 1,time:SLIDE_LENGTH,delay:TIME_BAR_FADE_DELAY,transition:TIME_BAR_TRANS,onComplete:function()
				{
					dispatchEvent(new Event(SLIDE_COMPLETE));
					Tweener.addTween(timeBar,
					{
						_autoAlpha:0,time:TIME_BAR_FADE_SPD,delay:TIME_BAR_FADE_DELAY,onComplete:function()
						{
							timeBar.width = 1;
						}
					});
				}
			});
		}

		public function reset():void
		{
			Tweener.removeTweens(timeBar,'width');
			Tweener.addTween(timeBar,
			{
				_autoAlpha:0,time:TIME_BAR_FADE_SPD,onComplete:function()
				{
					timeBar.width = 1;
				}
			});
		}

		public function get id():uint
		{
			return thumbID;
		}
	}
}

