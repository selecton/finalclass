package net.finalclass.db.schema
{
	import net.finalclass.db.Entity;
	import net.finalclass.db.schema.relation.Relation;

	[DefaultProperty("columns")]
	public class Schema
	{
		[ArrayElementType("net.finalclass.db.schema.Column")]
		public var columns:Array = new Array();
		
		[ArrayElementType("net.finalclass.db.schema.relation.Relation")]
		public var relations:Array = new Array();
		
		public var entityClass:Class = Entity;
		
		
		public function Schema()
		{
			
		}
		
		static public function create() : Schema
		{
			return new Schema();
		}
		
		public function addColumn(col:Column) : Schema
		{
			if( !hasColumn(col.name) )
				columns.push(col);
			
			return this;
		}
		
		public function addRelation(relation:Relation) : Schema
		{
			if( hasRelation(relation.name) )
				return this;
			
			relations.push(relation);
			return this;
		}
		
		public function setEntityClass(entityClass:Class) : Schema
		{
			this.entityClass = entityClass;
			return this;
		}
		
		public function hasColumn(name:String) : Boolean
		{
			for(var i:int = 0; i < columns.length; i++)
				if( Column(columns[i]).name == name )
					return true;
			return false;
		}
		
		public function hasRelation(name:String) : Boolean
		{
			for(var i:int = 0; i < relations.length; i++)
				if( Relation(relations[i]).name == name )
					return true;
			return false;
		}
		
		public function getRelation(name:String) : Relation
		{
			for(var i:int = 0; i < relations.length; i++)
				if( Relation(relations[i]).name == name )
					return relations[i];
			return null
		}
		
	}
}