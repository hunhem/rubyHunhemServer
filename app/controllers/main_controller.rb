class MainController < ApplicationController
	include Info::Test

	def main
		Rails.logger.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@ main @@@@@@@@@@@@@@@@@@@@@@")
		Rails.logger.info(ttt)
	end
end
