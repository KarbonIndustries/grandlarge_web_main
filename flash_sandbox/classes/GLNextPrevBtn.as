package classes
{
	import flash.display.*;
	import flash.events.*;
	import caurina.transitions.*;
	import caurina.transitions.properties.DisplayShortcuts;
	DisplayShortcuts.init();

	public class GLNextPrevBtn extends Sprite
	{
/* ============= */
/* = CONSTANTS = */
/* ============= */

/* ========== */
/* = EVENTS = */
/* ========== */

/* ============== */
/* = PROPERTIES = */
/* ============== */


		public function GLNextPrevBtn(type:String = null)
		{
			super();
			type == 'prev' ? reverse() : null;
		}
		
		private function reverse():void
		{
			var btn = this.getChildAt(0);
			btn.scaleX = -1;
			btn.x = btn.width;
		}
	}
}