package net.finalclass.db {
	
	import mx.collections.IList;
	import mx.collections.Sort;
	
	import net.finalclass.db.schema.Schema;
	
	/**
	 * @author Szymon Wygnański ( szymon(at)selecton.net )
	 */
	[DefaultProperty("schema")]
	public class EntitiesTable {
		
		private var _index:Object;
		private var _data:EntitiesCollection;
		private var _sorting:Sort = null;
		
		private var _schema:Schema = new Schema();
		
		public function EntitiesTable() {
			_data = _createCollection();
			truncate();
		}
		
		/**
		 * @private
		 */
		public function set dataProvider(value:IList) : void
		{
			truncate();
			for(var i:int = 0; i < value.length; i++)
			{
				var obj:Object = value.getItemAt(i) as Object;
				var xml:XML = obj as XML;
				var entity:Entity = obj as Entity;
				if( entity == null )
				{
					entity = new Entity();
					if( xml != null )
					{
						entity.fromXML(xml);
					}
					else if( obj != null )
					{
						entity.fromObj(obj);
					}
				}
				add(value.getItemAt(i) as Entity);
			}
		}
		
		public function get dataProvider() : IList
		{
			return _data;
		}
		
		/**
		 * @private
		 */
		public function set sort(value:Sort) : void
		{
			_sorting = value;
			_data.sort = _sorting;
			_data.refresh();
			for(var property:String in _index)
			{
				for(var propertyValue:String in _index[property])
				{
					var collection:EntitiesCollection = _index[property][propertyValue] as EntitiesCollection;
					collection.sort = _sorting;
					collection.refresh();
				}
			}
		}
		
		public function get sort() : Sort
		{
			return _sorting;
		}
		
		public function set schema(schema:Schema) : void
		{
			_schema = schema;
		}
		
		public function get schema() : Schema
		{
			return _schema;
		}
		
		public function updateEntityIndex(en:Entity, indexToUpdate:String, oldValue:*) : void
		{	
			if( en[indexToUpdate] == oldValue )
				return;
			
			if( ! _index[indexToUpdate] )
				return;
			
			var collection:EntitiesCollection = _index[indexToUpdate][oldValue] as EntitiesCollection;
			collection.remove(en);
			_addToIndex(indexToUpdate, en);
		}
		
		public function update(en:Entity, oldValues:Object) : void
		{
			var index:String;
			var collection:EntitiesCollection;
		
			if( ! _data.exists(en) )
			{
				add(en);
				return;
			}
			
			for (var property:String in _index)
			{
				//If no change was made
				if(en[property] == oldValues[property])
					continue;
				//If change in index was made then remove item from old index and add to new one
				collection = _index[property][ oldValues[property] ] as EntitiesCollection;
				collection.remove(en);
				_addToIndex(property, en);
			}
		}
		
		public function truncate() : void {
			_data = _createCollection();
			_index = new Object();
		}
		
		/* indexes */
		private function _addToIndex( indexProperty:String, item:Entity ) : void {
			if( ! _index[indexProperty][ item[indexProperty] ] )
				_index[indexProperty][ item[indexProperty] ] = _createCollection();
			_index[indexProperty][ item[indexProperty] ].addItem( item );
		}
		
		public function get length() : int
		{
			return _data.length;
		}
		
		protected function _addIndex(indexProperty:String) : void {
			if( _index[indexProperty] != undefined ) return;
			
			_index[ indexProperty ] = new Object();
			
			for( var i:uint = 0; i < _data.length; i++ )
				_addToIndex( indexProperty, _data.getItemAt(i) as Entity );
		}
		
		protected function _removeIndex( indexProperty:String ) : void {
			if( _index[indexProperty] == undefined )
				return;
			
			delete _index[indexProperty];
		}
		
		/* Adding items */
		
		public function addMany(items:Array) : void {
			for(var i:int = 0; i < items.length; i++)
				add(items[i]);
		}
		
		public function add(item:Entity) : Entity {
			item.attach(this);
			_data.addItem(item);
			
			for (var property:String in _index)
				_addToIndex( property, item );
			
			return item;
		}
		
		/* Removing items */
		
		public function remove(item:Entity) : Entity {
			var index:int = _data.getItemIndex(item);
			if( index == -1 )
				throw new Error('Nie można usunąć ValueObject z proxy. Podany vo nie istenieje');
			_data.removeItemAt(index);
			
			for (var property:String in _index) {
				var ac:EntitiesCollection = _index[property][ item[property] ];
				var inArrayIndex:int = ac.getItemIndex(item);
				ac.removeItemAt(inArrayIndex);
			}
			return item;
		}
		
		public function removeFor(propertyName:String, value:String) : EntitiesCollection {
			var toRem:EntitiesCollection;
			var i:int;
			
			toRem = findBy(propertyName, value);
			
			for(i = 0; i < toRem.length;i++) 
				remove( toRem.getItemAt(i) as Entity );
			
			return toRem;
		}
		
		/* Retriveing items */
		
		public function find(id:String) : Entity
		{
			return findFirstBy('id', id);
		}
		
		public function findBy(propertyName:String, value:String) : EntitiesCollection {
			if( _index[propertyName] == undefined )
				_addIndex(propertyName);
			
			if( _index[ propertyName ][ value ] )
				return _index[ propertyName ][ value ];
			else return _createCollection();
		}
		
		public function findAll() : EntitiesCollection {
			return _data;
		}
		
		public function findFirstBy(propertyName:String, value:String) : Entity {
			var result:EntitiesCollection = findBy(propertyName, value);
			if( result.length == 0 ) return null;
			return result.getItemAt(0) as Entity;
		}
		
		protected function _createCollection() : EntitiesCollection {
			var ec:EntitiesCollection = new EntitiesCollection();
			if( _sorting != null )
				ec.sort = _sorting;
			return ec;
		}
		
	}
}