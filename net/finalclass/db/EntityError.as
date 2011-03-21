package net.finalclass.db
{
	public class EntityError extends Error
	{
		public function EntityError(message:*="", id:*=0)
		{
			super(message, id);
		}
	}
}