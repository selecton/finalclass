package net.finalclass.db
{
	import mx.collections.ArrayCollection;

	public class EntitiesCollection extends ArrayCollection
	{
		
		public function EntitiesCollection(source:Array = null)
		{
			super(source);
		}
		
		/**
		 * @return Entity the item that was removed
		 */
		public function remove(entity:Entity) : Entity
		{
			return removeItemAt( getItemIndex(entity) ) as Entity;
		}
		
		public function exists(item:Entity) : Boolean
		{
			return getItemIndex(item) != -1;
		}
	}
}