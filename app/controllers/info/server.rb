module Info::Server

	private

	def server_version
		version = "1.0.0"
		return version
	end

	def game_value(difficulty)
		game_value = GameValue.where(name: difficulty).first
	
		Rails.logger.info("@@@@@@ game_value(difficulty) @@@@@")
		Rails.logger.info(game_value)	
		
		if game_value != nil
			hash = 
			{
				playerSpeed: game_value.playerSpeed,
				playerMinSize: game_value.playerMinSize,
				playerShrinkVal: game_value.playerShrinkVal,
				playerGrowVal: game_value.playerGrowVal,
				playerContGrowVal: game_value.playerContGrowVal,
				sEneMinSize: game_value.sEneMinSize,
				sEneMaxSize: game_value.sEneMaxSize,
				sEneSpawnFreq: game_value.sEneSpawnFreq,
				sEneSpeedMulti: game_value.sEneSpeedMulti,
				bEneMinSize: game_value.bEneMinSize,
				bEneMaxSize: game_value.bEneMaxSize,
				bEneSpawnFreq: game_value.bEneSpawnFreq,
				bEneSpeedMulti: game_value.bEneSpeedMulti,
				triMinSize: game_value.triMinSize,
				triMaxSize: game_value.triMaxSize,
				triSpawnFreq: game_value.triSpawnFreq,
				triSpeedMulti: game_value.triSpeedMulti,
			}
		end		

	end

end
