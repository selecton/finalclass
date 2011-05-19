package net.finalclass.events
{
	import flash.events.Event;
	
	public class ValueEvent extends Event
	{
		
		static public const INCREASE:String = 'increase';
		static public const DECREASE:String = 'decrease';
		
		public var value:Number;
		
		public function ValueEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, value:Number = 0)
		{
			super(type, bubbles, cancelable);
			this.value = value;
		}
	}
}