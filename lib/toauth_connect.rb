module ToauthConnect
	require "toauth_connect/version"
	require 'helpers/configuration'
	extend Configuration

	define_setting :client_id
	define_setting :client_secret
	define_setting :domain_default
	define_setting :url_redirect_production
	define_setting :url_redirect_dev
	define_setting :url_redirect_staging
	define_setting :user_table
	define_setting :column_email
	define_setting :column_token
	define_setting :column_name
	define_setting :column_cpf
	define_setting :column_password
	define_setting :column_password_confirmation

	def self.url
		"http://toauth.seplan.to.gov.br/"	
	end

	def self.redirect_url
		if Rails.env.production
			url_redirect_production
		elsif Rails.env.staging
			url_redirect_staging
		else
			url_redirect_dev
		end
	end

	def self.client_auth		
		user = OAuth2::Client.new(client_id, client_secret, :site => url)
		if user.blank?
			return {error: true}
		end
		user
	end
	
	def self.logout
		"#{url}users/sign_out"
	end

	def self.auth_url
		client_auth.auth_code.authorize_url(:redirect_uri => redirect_url)
	end

	def self.login(code)
		token = client_auth.auth_code.get_token(code, :redirect_uri => redirect_url)
		get_user_by_token(token.token)
	end

	def self.get_user_by_token(token)
		dados = RestClient.get("#{url}/api/me.json?access_token=#{token}")
		user_data =  JSON.parse(dados, symbolize_names: true)
		password = SecureRandom.urlsafe_base64(nil, false)

		user = user_table.constantize.find_or_initialize_by(cpf:user_data[:cpf])

		user.send("#{column_email}=", user_data[:email])
		user.send("#{column_password}=", password)
		user.send("#{column_password_confirmation}=", password)
		user.send("#{column_token}=", token)
		user.send("#{column_name}=", user_data[:name])
		user.save
		user
	end

	def self.fastdata(user)
		data = RestClient.get("#{url}/api/me.json?access_token=#{user.send(column_token)}")
    	JSON.parse(data, symbolize_names: true)
	end

	def self.profile_data(user)
		data = RestClient.get("#{url}/api/me/profile.json?access_token=#{user.send(column_token)}")
    	JSON.parse(data, symbolize_names: true)
	end
end
