package net.finalclass.components
{
	import mx.binding.utils.BindingUtils;
	import mx.controls.Image;
	import mx.events.FlexEvent;
	
	import net.finalclass.skins.DynamicImageButtonSkin;
	
	import spark.components.Button;
	
	[DefaultProperty("source")]
	
	public class DynamicImageButton extends Button
	{
		
		[SkinPart(required="true")]
		public var image:Image;
		
		[Bindable]
		public var source:String;
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			switch(partName)
			{
				case "image":
					BindingUtils.bindProperty(image, 'source', this, 'source');
					break;
			}
		}
		
	}
}