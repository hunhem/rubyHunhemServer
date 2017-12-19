class AccountController < ApplicationController
	skip_before_filter :verify_authenticity_token
	
	include Info::Server
	
  def sign_up
		@user = User.new		

		account = params[:account]
		hash = JSON.parse account
		Rails.logger.info("@@@@ sign_up @@@@")
		Rails.logger.info(hash)
		
		id = hash["id"]
		password = hash["password"]
		passwordConfirm = hash["passwordConfirm"]
			
		if id_exist(id)
			Rails.logger.info("exist")
			render json: {message: 'Existing Account'}, status: 500
		elsif check_limit_length(id)
			render json: {message: 'Account length limit exceeded'}, status: 500
		else
			if password_confirm(password, passwordConfirm)
				Rails.logger.info("@@@@ sign_up 1@@@@")
				salt = BCrypt::Engine.generate_salt
				encrypted_password = BCrypt::Engine.hash_secret(password, salt)
				@user.account = id
				@user.encrypted_password = encrypted_password
				@user.salt = salt
				Rails.logger.info("@@@@ sign_up 2@@@@")
			
				if @user.save
					render json: {message: '성공'}, status: 200
					Rails.logger.info("@@@@ sign_up 3@@@@")
				else
					render json: {message: '실패'}, status: 500
					Rails.logger.info("@@@@ sign_up 4@@@@")
				end
			else
				render json: {message: 'Incorrect Password'}, status: 500
				Rails.logger.info("@@@@ sign_up 5@@@@")
			end
		end
  end

  def log_in
		server_key = "001"
		server_salt = "$2a$10$04a6zaQbDS.zL3SP69r0cu"
		
		session = BCrypt::Engine.hash_secret(server_key, server_salt)		

		account = params[:account]
		hash = JSON.parse account
		Rails.logger.info("@@@@ log_in @@@@")
		Rails.logger.info(hash)
		
		input_id = hash["id"]
		input_password = hash["password"]
		#versionName = "1.0.0"
		versionName = hash["versionName"]
		Rails.logger.info("@@@@ version_check @@@@")
		Rails.logger.info(server_version)
				
		user = User.where(account: input_id).first

		if versionName != server_version
			render json: {message: 'Version is different. Please update your game', code: '500'}, status: 500
		elsif user == nil
			render json: {message: 'Nonexistent Account'}, status: 500
		else
			salt = user.salt
			encrypted_password = BCrypt::Engine.hash_secret(input_password, salt)
			if user.encrypted_password != encrypted_password
				render json: {message: 'Incorrect Password'}, status: 500
			else
				user.session = BCrypt::Engine.generate_salt
				user.save
				render json: {message: '성공', session: user.session}, status: 200
			end
		end
		server_password = nil
  end
	
	def log_out
		render json: {message: '성공'}, status: 200
	end

	def init_difficulty
		Rails.logger.info("@@@@@@@ init_dificulty @@@@@@")
		hash = game_value("basic")
		Rails.logger.info(hash)
		render json: {init_difficulty: hash}, status: 200
	end

	private
	
	def password_confirm(str1, str2)
		if str1 == str2
			return true
		else
			return false
		end
	end

	def id_exist(str)
		user = User.where(account: str).first
		if user == nil
			return false
		else
			return true
		end
	end

	def check_limit_length(str)
		limit_length = 8
		if str.length > limit_length
			return true
		else
			return false
		end
	end
end
