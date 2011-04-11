package net.finalclass.events
{
	import flash.events.Event;
	
	public class ToggleTreeEvent extends Event
	{
		static public const ENTER_FIRST:String = 'enterFirst';
		static public const EXIT_FIRST:String = 'exitFirst';
		static public const ENTER_SECOND:String = 'enterSecond';
		static public const EXIT_SECOND:String = 'exitSecond';
		static public const ENTER_THIRD:String = 'enterThird';
		static public const EXIT_THIRD:String = 'exitThird';
		
		public function ToggleTreeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}