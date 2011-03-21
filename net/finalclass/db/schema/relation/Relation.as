package net.finalclass.db.schema.relation
{
	import net.finalclass.db.EntitiesTable;

	public class Relation
	{	
		
		public function Relation(name:String = '')
		{
			this.name = name;
		}
		
		//////////////////////////////////////////////////////////TABLE
		private var _table:EntitiesTable;
		
		public function set table(value:EntitiesTable) : void
		{
			_table = value;
		}
		
		public function get table() : EntitiesTable
		{
			return _table;
		}
		
		public function setTable(value:EntitiesTable) : Relation
		{
			_table = value;
			return this;
		}
		
		
		///////////////////////////////////////////////NAME
		public var name:String;
		
		public function setName(value:String) : Relation
		{
			this.name = value;
			return this;
		}
		
		/////////////////////////////////////////////////////COLUMN NAME
		private var _columnName:String = '';
		
		public function set columnName(value:String) : void
		{
			_columnName = value;
		}
		
		public function get columnName() : String
		{
			if( _columnName.length == 0 )
				return name + '_id';
			return _columnName;
		}
		
		public function setColumnName(value:String) : Relation
		{
			_columnName = value;
			return this;
		}
		
		////////////////////////////////////////////////////REFERENCED COLUMN NAME
		private var _referencedColumnName:String = 'id';
		
		public function set referencedColumnName(value:String) : void
		{
			_referencedColumnName = value;
		}

		public function get referencedColumnName() : String
		{
			if( _referencedColumnName.length == 0 )
				return 'id';
			return _referencedColumnName;
		}
		
		public function setReferencedColumnName(value:String) : Relation
		{
			_referencedColumnName = value;
			return this;
		}
		
		
	}
}