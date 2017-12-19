class Score < ActiveRecord::Base
	belongs_to :user
	belongs_to :rank
	def	to_hash
		{
			id: id,
			score: score,
			account: account,
		}
	end
end
