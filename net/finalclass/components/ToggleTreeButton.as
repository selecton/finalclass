package net.finalclass.components
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.events.FlexEvent;
	import mx.states.State;
	
	import net.finalclass.skins.ToggleTreeButtonSkin;
	
	import spark.components.supportClasses.SkinnableComponent;
	
	[SkinState("firstUp")]
	[SkinState("firstOver")]
	[SkinState("firstDown")]
	[SkinState("firstDisabled")]
	[SkinState("secondUp")]
	[SkinState("secondOver")]
	[SkinState("secondDown")]
	[SkinState("secondDisabled")]
	[SkinState("thirdUp")]
	[SkinState("thirdOver")]
	[SkinState("thirdDown")]
	[SkinState("thirdDisabled")]
	
	[Event(name="enterFirst", type="flash.events.Event")]
	[Event(name="exitFirst", type="flash.events.Event")]
	[Event(name="enterSecond", type="flash.events.Event")]
	[Event(name="exitSecond", type="flash.events.Event")]
	[Event(name="enterThird", type="flash.events.Event")]
	[Event(name="exitThird", type="flash.events.Event")]
	public class ToggleTreeButton extends SkinnableComponent
	{
		
		private var _isMouseOver:Boolean = false;
		private var _isMouseDown:Boolean = false;
		
		private var _firstState:State;
		private var _secondState:State;
		private var _thirdState:State;
		
		static public const STATE_FIRST:String = 'first';
		static public const STATE_SECOND:String = 'second';
		static public const STATE_THIRD:String = 'third';
		
		private var _toggleMode:Boolean;
		
		public function ToggleTreeButton()
		{
			super();
			
			setStyle("skinClass", ToggleTreeButtonSkin);
			
			_firstState = new State();
			_firstState.name = STATE_FIRST;
			
			_secondState = new State();
			_secondState.name = STATE_SECOND;
			
			_thirdState = new State();
			_thirdState.name = STATE_THIRD;
			
			states = [ _firstState, _secondState, _thirdState ];
			
			currentState = STATE_FIRST;
			
			toggleMode = true;
			
			addEventListener(Event.ADDED_TO_STAGE, _addEventListeners, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, _removeEventListeners, false, 0, true);
			
			if( stage != null ) _addEventListeners();
		}
		
		private function _addEventListeners(event:Event = null) : void
		{
			addEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
			addEventListener(MouseEvent.MOUSE_OVER, _onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, _onMouseOut);
			_firstState.addEventListener(FlexEvent.ENTER_STATE, _enterFirst);
			_firstState.addEventListener(FlexEvent.EXIT_STATE, _exitFirst);
			_secondState.addEventListener(FlexEvent.ENTER_STATE, _enterSecond);
			_secondState.addEventListener(FlexEvent.EXIT_STATE, _exitSecond);
			_thirdState.addEventListener(FlexEvent.ENTER_STATE, _enterThird);
			_thirdState.addEventListener(FlexEvent.EXIT_STATE, _exitThird);
		}
		
		protected function _removeEventListeners(event:Event = null) : void
		{
			removeEventListener(MouseEvent.CLICK, _onMouseClick);
			removeEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
			stage.removeEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
			removeEventListener(MouseEvent.MOUSE_OVER, _onMouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT, _onMouseOut);
			_firstState.removeEventListener(FlexEvent.ENTER_STATE, _enterFirst);
			_firstState.removeEventListener(FlexEvent.EXIT_STATE, _exitFirst);
			_secondState.removeEventListener(FlexEvent.ENTER_STATE, _enterSecond);
			_secondState.removeEventListener(FlexEvent.EXIT_STATE, _exitSecond);
			_thirdState.removeEventListener(FlexEvent.ENTER_STATE, _enterThird);
			_thirdState.removeEventListener(FlexEvent.EXIT_STATE, _exitThird);
		}
		
		
		[Bindable]
		public function set toggleMode(value:Boolean) : void
		{
			if( value )
				addEventListener(MouseEvent.CLICK, _onMouseClick);
			else
				removeEventListener(MouseEvent.CLICK, _onMouseClick);
			
			_toggleMode = value;
		}
		
		public function get toggleMode() : Boolean
		{
			return _toggleMode;
		}
		
		private function _enterFirst(event:FlexEvent) : void
		{
			dispatchEvent(new Event("enterFirst"));
		}
		
		private function _exitFirst(event:FlexEvent) : void
		{
			dispatchEvent(new Event("exitFirst"));
		}
		
		private function _enterSecond(event:FlexEvent) : void
		{
			dispatchEvent(new Event("enterSecond"));
		}
		
		private function _exitSecond(event:FlexEvent) : void
		{
			dispatchEvent(new Event("exitSecond"));
		}
		
		private function _enterThird(event:FlexEvent) : void
		{
			dispatchEvent(new Event("enterThird"));
		}
		
		private function _exitThird(event:FlexEvent) : void
		{
			dispatchEvent(new Event("exitThird"));
		}
		
		private function _onMouseDown(event:MouseEvent) : void
		{
			_isMouseDown = true;
			invalidateSkinState();
		}
		
		private function _onMouseUp(event:MouseEvent) : void
		{
			_isMouseDown = false;
			invalidateSkinState();
		}
		
		private function _onMouseOver(event:MouseEvent) : void
		{
			_isMouseOver = true;
			invalidateSkinState();
		}
		
		private function _onMouseOut(event:MouseEvent) : void
		{
			_isMouseOver = false;
			invalidateSkinState();
		}
		
		[Bindable]
		override public function set currentState(value:String) : void
		{
			super.currentState = value;
			invalidateSkinState();
		}
		
		protected function _onMouseClick(event:MouseEvent) : void
		{
			switch(currentState) 
			{
				default:
				case STATE_FIRST:
					currentState = STATE_SECOND;
					break;
				case STATE_SECOND:
					currentState = STATE_THIRD;
					break;
				case STATE_THIRD:
					currentState = STATE_FIRST;
					break;
			}
			invalidateSkinState();
		}
		
		override protected function getCurrentSkinState() : String
		{	
			var suffix:String = '';
			
			if( ! enabled )
				suffix = 'Disabled';
			else if( _isMouseDown )
				suffix = 'Down';
			else if( _isMouseOver )
				suffix = 'Over';
			else
				suffix = 'Up';
			
			return currentState + suffix;
		}
		
	}
}