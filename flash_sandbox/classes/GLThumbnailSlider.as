package classes
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import caurina.transitions.*;
	import caurina.transitions.properties.DisplayShortcuts;
	DisplayShortcuts.init();

	public class GLThumbnailSlider extends Sprite
	{
/* ============= */
/* = CONSTANTS = */
/* ============= */
		private const DIM_ALPHA:Number				= .2;
		private const DIM_SPD:Number				= 1;
		private const DIM_TRANS:String				= 'easeOutQuint';
		private const BTN_FADE_SPD:Number			= 1;
		private const BTN_FADE_TRANS:String			= 'easeOutQuint';
		private const THUMB_SLIDE_SPD:Number		= 1;
		private const THUMB_SLIDE_TRANS:String		= 'easeInOutQuint';
		private const THUMB_WIDTH:Number			= 192;
		private const THUMB_HEIGHT:Number			= 108;
		private const THUMB_DISPLAY_NUM:uint		= 5;

/* ========== */
/* = EVENTS = */
/* ========== */
		private const THUMB_LOADED:String			= 'thumbLoaded';
		private const THUMBS_LOADED:String			= 'thumbsLoaded';
		private const THUMB_CLICKED:String			= 'thumbClicked';
		private const SLIDE_COMPLETE:String			= 'slideComplete';

/* ============== */
/* = PROPERTIES = */
/* ============== */
		private var thumb:GLThumbnail;
		private var xIndex:uint;
		private var nextBtn:GLNextPrevBtn;
		private var prevBtn:GLNextPrevBtn;
		private var thumbShell:Sprite;
		private var thumbStrip:Sprite;
		private var thumbMask:Sprite;
		private var thumbArea:Rectangle;
		private var imgSet:Array;
		private var thumbIndex:uint;
		private var totalItems:uint;
		private var thumbsLoaded:uint;
		private var thumbSet:Array;
		private var curIndex:uint;
		private var frameIndex:uint;
		private var _sameFrame:Boolean;

		public function GLThumbnailSlider()
		{
			super();
			xIndex = 0;
			thumbArea = new Rectangle(0,0,THUMB_WIDTH * THUMB_DISPLAY_NUM,THUMB_HEIGHT);
		}
		
		
/* =========== */
/* = METHODS = */
/* =========== */
		public function load(urls:Array):void
		{
			imgSet = urls;
			totalItems = imgSet.length;
			thumbStrip = new Sprite();
			thumbSet = new Array();
			for(var index:String in urls)
			{
				thumb = new GLThumbnail(urls[index],uint(index));
				thumb.addEventListener(THUMB_LOADED,thumbLoaded);
				thumb.addEventListener(MouseEvent.CLICK,thumbClicked);
				thumb.addEventListener(SLIDE_COMPLETE,slideComplete);
				thumb.x = xIndex;
				thumbStrip.addChild(thumb);
				xIndex += THUMB_WIDTH;
				thumbSet.push(thumb);
			}
			thumbShell = new Sprite();
			addChild(thumbShell);
			thumbShell.addChild(thumbStrip);
			thumbMask = new Sprite();
			with(thumbMask.graphics)
			{
				lineStyle();
				beginFill(0xFF0000,0);
				drawRect(0,0,THUMB_WIDTH * THUMB_DISPLAY_NUM,THUMB_HEIGHT);
				endFill();
			}
			thumbShell.addChild(thumbMask);
			thumbStrip.mask = thumbMask;
			if(urls.length > THUMB_DISPLAY_NUM)
			{
				prevBtn = new GLNextPrevBtn('prev');
				nextBtn = new GLNextPrevBtn();
				prevBtn.x = prevBtn.y = 0;
				nextBtn.x = THUMB_WIDTH * THUMB_DISPLAY_NUM - nextBtn.width;
				nextBtn.y = 0;
				prevBtn.buttonMode = nextBtn.buttonMode = true;
				thumbIndex = curIndex = 0;
				prevBtn.alpha = nextBtn.alpha = 0;
				prevBtn.visible = nextBtn.visible = false;
				prevBtn.addEventListener(MouseEvent.CLICK,prev);
				nextBtn.addEventListener(MouseEvent.CLICK,next);
				thumbShell.addEventListener(MouseEvent.MOUSE_MOVE,showNextPrev);
				thumbShell.addEventListener(MouseEvent.MOUSE_OUT,hideNextPrev);
				thumbShell.addChild(prevBtn);
				thumbShell.addChild(nextBtn);
			}
		}

		private function thumbLoaded(e:Event):void
		{
			thumbsLoaded++;
			thumbsLoaded == totalItems ? this.dispatchEvent(new Event(THUMBS_LOADED)) : null;
		}

		public function initSlideshow():void
		{
			curIndex = 0;
			thumbSet[curIndex].start();
		}

		private function slideComplete(e:Event):void
		{
			var newX:Number;
			curIndex = GLThumbnail(e.target).id + 1;
			if(curIndex >= imgSet.length)
			{
				curIndex = thumbIndex = 0;
				Tweener.addTween(thumbStrip,{x:0,time:THUMB_SLIDE_SPD,transition:THUMB_SLIDE_TRANS});
			}
			if(thumbSet[curIndex].x >= THUMB_DISPLAY_NUM * THUMB_WIDTH)
			{
				thumbIndex = Math.abs(((THUMB_DISPLAY_NUM * THUMB_WIDTH) - thumbSet[curIndex].x) / THUMB_WIDTH) + 1;
				newX = -thumbSet[curIndex].x + ((THUMB_DISPLAY_NUM - 1) * THUMB_WIDTH);
				Tweener.addTween(thumbStrip,{x:newX,time:THUMB_SLIDE_SPD,transition:THUMB_SLIDE_TRANS});
			}
			if(thumbStrip.x < -thumbSet[curIndex].x)
			{
				newX = -thumbSet[curIndex].x;
				thumbIndex = Math.abs(newX / THUMB_WIDTH);
				Tweener.addTween(thumbStrip,{x:newX,time:THUMB_SLIDE_SPD,transition:THUMB_SLIDE_TRANS});
			}
			thumbSet[curIndex].start();
			this.dispatchEvent(new Event(SLIDE_COMPLETE));
		}

		private function thumbClicked(e:Event = null):void
		{
			//resetSlider();
			thumbSet[curIndex].reset();
			curIndex = e ? GLThumbnail(e.currentTarget).id : frameIndex;
			this.dispatchEvent(new Event(THUMB_CLICKED));
		}

		public function get currentThumbId():uint
		{
			return curIndex;
		}

		public function get sameFrame():Boolean
		{
			return _sameFrame;
		}

		public function set dim(v:Boolean):void
		{
			(v == true && this.alpha > 0) ? Tweener.addTween(this,{alpha:DIM_ALPHA,time:DIM_SPD,transition:DIM_TRANS}) : Tweener.addTween(this,{alpha:1,time:DIM_SPD,transition:DIM_TRANS});
		}
		
		private function next(e:Event = null):void
		{
			if(thumbIndex < imgSet.length - THUMB_DISPLAY_NUM)
			{
				thumbIndex++;
				Tweener.addTween(thumbStrip,{x:-(thumbIndex * THUMB_WIDTH),time:THUMB_SLIDE_SPD,transition:THUMB_SLIDE_TRANS});
			}
		}
		
		private function prev(e:Event = null):void
		{
			if(thumbIndex > 0)
			{
				thumbIndex--;
				Tweener.addTween(thumbStrip,{x:-(thumbIndex * THUMB_WIDTH),time:THUMB_SLIDE_SPD,transition:THUMB_SLIDE_TRANS});
			}
		}

		public function reset(index:uint):void
		{
			frameIndex = index;
			_sameFrame = frameIndex == curIndex ? true : false;
			thumbClicked();
		}

		public function resetSlider():void
		{
			Tweener.addTween(thumbStrip,
			{
				x:0,time:THUMB_SLIDE_SPD,transition:THUMB_SLIDE_TRANS,onComplete:function()
				{
					curIndex = thumbIndex = 0;
				}
			});
		}

		private function showNextPrev(e:MouseEvent):void
		{
			if(nextBtn.alpha != 1 || nextBtn.visible != true)
			{
				Tweener.addTween(nextBtn,{_autoAlpha:1,time:BTN_FADE_SPD,transition:BTN_FADE_TRANS});
				Tweener.addTween(prevBtn,{_autoAlpha:1,time:BTN_FADE_SPD,transition:BTN_FADE_TRANS});
			}
		}
		
		private function hideNextPrev(e:MouseEvent):void
		{
			if(nextBtn.alpha > 0)
			{
				Tweener.addTween(nextBtn,{_autoAlpha:0,time:BTN_FADE_SPD,delay:.5,transition:BTN_FADE_TRANS});
				Tweener.addTween(prevBtn,{_autoAlpha:0,time:BTN_FADE_SPD,delay:.5,transition:BTN_FADE_TRANS});
			}
		}
	}
}

