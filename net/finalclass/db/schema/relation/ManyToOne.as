package net.finalclass.db.schema.relation
{
	public class ManyToOne extends Relation
	{
		public function ManyToOne(name:String = '')
		{
			super(name);
		}
		
		static public function create(name:String = '') : ManyToOne
		{
			return new ManyToOne(name);
		}
	}
}