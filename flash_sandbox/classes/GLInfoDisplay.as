package classes
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.*;
	import caurina.transitions.*;
	import caurina.transitions.properties.DisplayShortcuts;
	DisplayShortcuts.init();

	public class GLInfoDisplay extends Sprite
	{
/* ==================== */
/* = CONFIG CONSTANTS = */
/* ==================== */
		private const AUTHOR_NAME					= 'Karbon Inc.';

/* =================== */
/* = TWEEN CONSTANTS = */
/* =================== */
		private const FADE_SPD:Number				= 1;
		private const FADE_TRANS:String				= 'easeOutExpo';

/* ========== */
/* = COLORS = */
/* ========== */
		const GL_BLUE:uint							= 0x65A7C0;
		const BLACK:uint							= 0x000000;
		const WHITE:uint							= 0xFFFFFF;
		const GREY:uint								= 0x424242;

/* ======================= */
/* = TEXTFIELD CONSTANTS = */
/* ======================= */
		private const TF_COLOR_1:uint				= GL_BLUE;
		private const TF_COLOR_2:uint				= WHITE;
		private const TF_COLOR_3:uint				= WHITE;
		private const TF_FONT_1:String				= 'Lucida Sans Typewriter Std';
		private const TF_FONT_2:String				= 'Lucida Sans Typewriter Std';
		private const TF_FONT_3:String				= 'Lucida Sans Typewriter Std';
		private const TF_SIZE:Number				= 17;
//		private const TF_SIZE:Number				= 21.5;
		//private const TF_SIZE:Number				= 27.6;
		private const TF_LETTER_SPACING:Number		= 1;
//		private const TF_LETTER_SPACING:Number		= .3;
		private const SEPARATOR:String				= ' / ';

/* ======================= */
/* = TEXTFIELD VARIABLES = */
/* ======================= */
		private var tf:TextField;
		private var tff1:TextFormat;
		private var tff2:TextFormat;
		private var tff3:TextFormat;
		private var tffSet:Array;
		private var txt1:String;
		private var txt2:String;
		private var txt3:String;
		private var len1:uint;
		private var len2:uint;
		private var len3:uint;
		private var lens:uint;
		private var string:String;
		private var charIndex:uint;

/* =================== */
/* = TIMER CONSTANTS = */
/* =================== */
		private const MS:uint						= 1000;
		private const TMR_DELAY:Number				= .0005;

/* =================== */
/* = TIMER VARIABLES = */
/* =================== */
		private var timer:Timer;

		public function GLInfoDisplay(text1:String = null,text2:String = null,text3:String = null)
		{
			super();
			txt1 = containsValue(text1) ? text1 : null;
			txt2 = containsValue(text2) ? text2 : null;
			txt3 = containsValue(text3) ? text3 : null;
			init();
		}

/* =========== */
/* = METHODS = */
/* =========== */		
		private function init():void
		{
			tff1 = new TextFormat();
			tff2 = new TextFormat();
			tff3 = new TextFormat();
			tffSet = new Array();
			tffSet.push(tff1);
			tffSet.push(tff2);
			tffSet.push(tff3);
			for each(var tff:TextFormat in tffSet)
			{
				tff.size = TF_SIZE;
				tff.letterSpacing = TF_LETTER_SPACING;
				tff.kerning = false;
			}
			tff1.color = TF_COLOR_1;
			tff2.color = TF_COLOR_2;
			tff3.color = TF_COLOR_3;
			tff1.font = TF_FONT_1;
			tff1.bold = true;
			tff2.font = TF_FONT_2;
			tff2.bold = true;
			tff3.font = TF_FONT_3;
			tff3.bold = true;
			tf = new TextField();
			with(tf)
			{
				embedFonts = true;
				antiAliasType = AntiAliasType.ADVANCED;
				autoSize = TextFieldAutoSize.LEFT;
				multiline = false;
				selectable = false;
				border = false;
				defaultTextFormat = tff1;
			}
			timer = new Timer(0);
			timer.addEventListener(TimerEvent.TIMER,nextChar);
			txt1 || txt2 || txt3 ? updateDisplay(txt1,txt2,txt3) : null;
			addChild(tf);
		}
		
		private function containsValue(v:*):Boolean
		{
			return (Karbonizer.isSet(v) && !Karbonizer.isEmpty(v)) ? true : false;
		}
		
		public function updateDisplay(text1:String,text2:String = null,text3:String = null):void
		{
			txt1 = containsValue(text1) ? text1 : null;
			txt2 = containsValue(text2) ? text2 : null;
			txt3 = containsValue(text3) ? text3 : null;
			len1 = containsValue(txt1) ? txt1.length : 0;
			len2 = containsValue(txt2) ? SEPARATOR.length + txt2.length : 0;
			len3 = containsValue(txt3) ? SEPARATOR.length + txt3.length : 0;
			lens = len1 + len2 + len3;
			string = containsValue(txt1) ? txt1 + (containsValue(txt2) ? SEPARATOR + txt2 + (containsValue(txt3) ? SEPARATOR + txt3 : '') : '') : '';
			charIndex = 0;
			timer.delay = TMR_DELAY;
			timer.repeatCount = Math.max(tf.length,lens);
			timer.reset();
			timer.start();
		}
		
		private function nextChar(e:Event):void
		{
			if(charIndex < lens)
			{
				tf.replaceText(charIndex,charIndex + 1,string.charAt(charIndex));
				charIndex < len1 ? tf.setTextFormat(tff1,charIndex,charIndex + 1) : null;
				(charIndex > len1 - 1 && charIndex < len1 + len2) ? tf.setTextFormat(tff2,charIndex,charIndex + 1) : null;
				(charIndex > len1 + len2 - 1) ? tf.setTextFormat(tff3,charIndex,charIndex + 1) : null;
			}else
			{
				tf.replaceText(charIndex,charIndex + 1,' ');
			}
			charIndex++;
		}
		
		public function set text(val:String):void
		{
			tf.text = val ? val : '';
		}
	}
}