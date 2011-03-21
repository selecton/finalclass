package net.finalclass.db.schema.relation
{
	public class OneToMany extends Relation
	{
		public function OneToMany(name:String = '')
		{
			super(name);
		}
		
		static public function create(name:String = '') : OneToMany
		{
			return new OneToMany(name);
		}
	}
}