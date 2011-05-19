package net.finalclass.layouts
{
	import mx.core.ILayoutElement;
	
	import spark.components.supportClasses.GroupBase;
	import spark.layouts.supportClasses.LayoutBase;
	
	/**
	 * Found here:
	 * http://evtimmy.com/2009/06/flowlayout-a-spark-custom-layout-example/
	 * I've made little improvements
	 */
	public class FlowLayout extends LayoutBase
	{
		
		private var _horizontalGap:Number = 10;
		
		private var _verticalGap:Number = 0;
		
		override public function updateDisplayList(containerWidth:Number, containerHeight:Number):void
		{
			var x:Number = 0;
			var y:Number = 0;
			
			var layoutTarget:GroupBase = target;
			var count:int = layoutTarget.numElements;
			for(var i:int = 0; i < count; i++)
			{
				var element:ILayoutElement = layoutTarget.getElementAt(i);
				element.setLayoutBoundsSize(NaN, NaN);
				var elementWidth:Number = element.getLayoutBoundsWidth();
				var elementHeight:Number = element.getLayoutBoundsHeight();
				
				if(x + elementWidth > containerWidth)
				{
					x = 0;
					y += elementHeight + verticalGap;
				}
				
				element.setLayoutBoundsPosition(x, y);
				x += elementWidth + horizontalGap;
			}
			layoutTarget.height = y;
		}
		
		[Bindable]
		public function set horizontalGap(value:Number) : void
		{
			if( _horizontalGap == value )
				return;
			
			_horizontalGap = value;
			invalidateTargetSizeAndDisplayList();
		}
		
		public function get horizontalGap() : Number
		{
			return _horizontalGap;
		}
		
		[Bindable]
		public function set verticalGap(value:Number) : void
		{
			if( _verticalGap == value )
				return;
			
			_verticalGap = value;
			invalidateTargetSizeAndDisplayList();
		}
		
		public function get verticalGap() : Number
		{
			return _verticalGap;
		}
		
		private function invalidateTargetSizeAndDisplayList():void
		{
			var g:GroupBase = target;
			if (!g)
				return;
			
			g.invalidateSize();
			g.invalidateDisplayList();
		}
		
	}
}