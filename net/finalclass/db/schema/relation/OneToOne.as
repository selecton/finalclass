package net.finalclass.db.schema.relation
{
	public class OneToOne extends Relation
	{
		
		public function OneToOne(name:String = '')
		{
			super(name);
		}
		
		static public function create(name:String = '') : OneToOne
		{
			return new OneToOne(name);
		}
	}
}