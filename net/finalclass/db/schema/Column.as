package net.finalclass.db.schema
{
	
	[DefaultProperty("name")]
	public class Column
	{
		public var name:String;
		
		public function Column(name:String = '')
		{
			this.name = name;
		}
		
		static public function create(name:String) : Column
		{
			return new Column(name);
		}
	}
}