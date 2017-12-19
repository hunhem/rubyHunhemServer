class ScoresController < ApplicationController
	skip_before_filter :verify_authenticity_token
	
	def regist_score
		Rails.logger.info("@@@@@ regist_score @@@@@")
		json = params[:score]
		hash = parsor_json(json)
		
		session = hash["session"]
		Rails.logger.info(session)
		score = hash["score"].to_i

		@user = User.where(session: session).first

		if(@user == nil)
			render json: {message: '실패'}, status: 500
		else
			@score = Score.new(user_id: @user.id, score: score, account: @user.account)
			@score.save
			if (@user.high_score < score)
				@user.update(high_score: score)
			end
			regist_rank(score)

			@rank = Rank.all
			@ten_ranks = ten_rank
			@user_rank = Rank.where(rank_score: score, account: @user.account).first
			if @user_rank != nil
				@user_rank = @user_rank.rank
			end

			Rails.logger.info("@@@@@@@@@@@@@@@@ hash_test @@@@@@@@@@@@@@@@@")
			Rails.logger.info(near_rank(@user_rank))

			@user.session = BCrypt::Engine.generate_salt
			@user.save

			hash = {
				session: @user.session, 
				user_score: score,
				user_rank: @user_rank,
				near_rank_info: near_rank(@user_rank),
				ten_ranks: @ten_ranks,
			}
			Rails.logger.info(hash)
			Rails.logger.info(" @@@@@@@@@@@@@@@@@@@@@@@@@@  regist score end     @@@@@@@@@@@@@@@@@@@@@@@@ ")
			
			render json: {rank: hash}, status: 200
		end
	end

	private

	def ten_rank
		ten_ranks = Rank.select("id,rank,account,rank_score").first(10)
		hash = []
		ten_ranks.each do |rank|
			if rank.account != nil
				hash << rank
			end
		end
		return hash
	end
	
	def near_rank(user_rank)
		if user_rank != nil
			two_up = Rank.select("id,rank,account,rank_score").where(rank: user_rank - 2).first
			one_up = Rank.select("id,rank,account,rank_score").where(rank: user_rank - 1).first
			one_down = Rank.select("id,rank,account,rank_score").where(rank: user_rank + 1).first
			two_down = Rank.select("id,rank,account,rank_score").where(rank: user_rank + 2).first

			two_up = check_nil_near_rank(two_up)
			one_up = check_nil_near_rank(one_up)
			one_down = check_nil_near_rank(one_down)
			two_down = check_nil_near_rank(two_down)			

			{
				two_up_rank: two_up,
				one_up_rank: one_up,
				one_down_rank: one_down,
				two_down_rank: two_down,
			}
		end
	end

	def check_nil_near_rank(rank)
		if rank != nil
			if rank.account == nil
				rank = nil
			end
		end
		return rank
	end

	def check_rank_in
		Rails.logger.info("@@@@@ check_rank_in @@@@@")
		@user = user
		
	end
		
	def regist_rank(score)
		Rails.logger.info("@@@@@ regist_rank @@@@@")
		init_rank

		sort = 1000
		
		@scores = Score.order(score: :desc).order(created_at: :asc).first(sort)
		if @scores.count < sort || @scores.last.score < score
			update_rank(@scores)
		end
	end

	def update_rank(scores)
		Rails.logger.info("@@@@@ update_rank @@@@@")
		i = 1
		@ranks = Rank.all
		scores.each do |s|
			rank = @ranks.where(rank: i).first
			rank.score_id = s.id
			rank.account = s.account
			rank.rank_score = s.score
			rank.save
			i += 1
		end
		Rails.logger.info("@@@@@ update_rank end @@@@@")
	end
	
	def init_rank
		Rails.logger.info("@@@@@ init_rank @@@@@")
		if Rank.first == nil
			for i in 1..1000
				rank = Rank.new(rank: i)
				rank.save
			end
		end
	end

	def issue_session
		
	end
	
	#def to_hash(score)
	#	sort = 10
	#	@ranks = Rank.select("rank,account,score").first(sort)
	#	
	#	hash = {
	#		user_score = score,
	#		user_rank = @ranks.where(score: score).first,
	#		ranks = @ranks,
	#	}
	#end

	def get_rank
		sort = 10
		@ranks = Score.select("id,score,account").order(score: :desc).first(sort)
	end

  def rank
		sort = 100
		@scores = Score.select("id,score").order(score: :desc).first(sort)
  end

	def test_hash
		@test_hash = {}
		scores = Score.order(score: :desc).first(10)
		
	end
end
