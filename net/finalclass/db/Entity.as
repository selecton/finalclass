package net.finalclass.db
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	import net.finalclass.db.schema.Schema;
	import net.finalclass.db.schema.relation.ManyToOne;
	import net.finalclass.db.schema.relation.OneToMany;
	import net.finalclass.db.schema.relation.OnetToOne;
	import net.finalclass.db.schema.relation.Relation;

	
	dynamic public class Entity extends Proxy
	{
		private var _table:EntitiesTable;
		private var _item:Object;
		
		public function Entity()
		{
			_item = new Object();
		}
		
		public function attach(table:EntitiesTable) : void
		{
			_table = table;
		}
		
		
		public function fromObject(obj:Object) : void
		{
			if( isAttached() )
			{
				var old:Object = _item;
				_item = obj;
				_table.update(this, old);
			}
			else
				_item = obj;
		}
		
		public function fromXML(xml:XML) : void
		{
			var obj:Object = new Object();
			for(var prop:String in xml)
			{
				if(xml.attributes().contains(prop) )	
					obj[prop] = xml.attribute(prop);
				else if( xml.elements().contains(prop) )
					obj[prop] = xml.elements(prop);
			}
			
			fromObject(obj);
		}
		
		public function isAttached(table:EntitiesTable = null) : Boolean
		{
			if(table == null )
				return _table != null;
			return _table == table;
		}
		
		protected function _update(property:String, value:*) : void
		{
			if( _table && ! _table.schema.hasColumn(property) )
				throw new EntityError('There is no property ' + property + ' in this entity');
			
			var old:* = _item[property];
			_item[property] = value;
			if( _table )
				_table.updateEntityIndex(this, property, old);
		}
		
		protected function _retrieve(property:String) : *
		{
			return _item[property];
		}
		
		override flash_proxy function callProperty(methodName:*, ... args):* {
			return null;
		}
		
		override flash_proxy function getProperty(name:*):* {
			var schema:Schema = _table.schema;
			
			if( schema.hasColumn(name) )
				return _retrieve(name);
			
			if( schema.hasRelation(name) )
			{
				var relation:Relation = schema.getRelation(name);
				if( relation is OnetToOne || relation is ManyToOne)
					return relation.table.findFirstBy(relation.referencedColumnName, _retrieve(relation.columnName) );
				else if(relation is OneToMany)
					return relation.table.findBy(relation.referencedColumnName, _retrieve(relation.columnName) );
			}

			throw new EntityError('There is no property or relation named: ' + name + ' in this entity');
		}
		
		override flash_proxy function setProperty(name:*, value:*):void {
			_update(name, value);
		}

		
		public function toString() : String
		{
			var columns:Array = _table.schema.columns;
			var out:String = 'Entity----------' + "\n";
			for(var i:int = 0; i < columns.length; i++)
			{
				out += "\t" + columns[i].name + ' = ' + _item[ columns[i].name ] + "\n";
			}
			out += '---------------' + "\n";
			return out;
		}
		
	}
}