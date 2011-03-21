package net.finalclass.db.schema.relation
{
	public class OnetToOne extends Relation
	{
		
		public function OnetToOne(name:String = '')
		{
			super(name);
		}
		
		static public function create(name:String = '') : OnetToOne
		{
			return new OnetToOne(name);
		}
	}
}