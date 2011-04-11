package net.finalclass.components
{
	import spark.components.supportClasses.ToggleButtonBase;
	
	public class ManualToggleButton extends ToggleButtonBase
	{
		
		public var manualSelection:Boolean = true;
		
		public function ManualToggleButton()
		{
			super();
		}
		
		override protected function buttonReleased():void
		{
			if( manualSelection )
				return;
			
			super.buttonReleased();
		}
		
	}
}