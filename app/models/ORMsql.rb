


module Orm

	# Because almost all of the find functions follow the format of the execute line below
	# this module should remove those lines of code.
	#
	# returns stuff from a field in a table that satisfies the condition.

	def select_from_where(column, table, constraint, isthis)

		return DB.execute("SELECT #{column} FROM #{table} WHERE #{constraint} = \"#{isthis}\"")

	end




end
