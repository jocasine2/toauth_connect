module SeraphAuth
	require "seraph_auth/version"

	def self.url
		"http://seraph.defensoria.to.gov.br/"	
	end

	def self.login(code)
		params = {
			grant_type: 'authorization_code',
			client_id: ENV['seraph_client'],
			client_secret: ENV['seraph_secret'],
			code: code
		}		
		begin 
			response_token = JSON.parse(
				RestClient.post("#{url}oauth2/access_token/", params), 
				symbolize_names: true
			)
			response  = JSON.parse(
				RestClient.get(
					"#{url}api/profile/", 
					{:Authorization => "Bearer #{response_token[:access_token]}" }
				), 
				symbolize_names: true
			)

			login = response[:username]
			cpf = response[:cpf]
			email = response[:email]
			nome = response[:first_name]
			matricula = response[:matricula]

			return usuario_login(login,cpf,email, nome, matricula)
		rescue
			return {error: true}
		end
	end

	def self.usuario_login(login,cpf,email, nome, matricula)
		user = User.find_by_username(login)
		if !user.blank?
			return user
		else
			return create_usuario(login,cpf,email,nome, matricula)
		end
	end

	def self.create_usuario(login,cpf,email,nome=nil,matricula=nil)
		senha = SecureRandom.urlsafe_base64(nil, false)
		user_params = {
			:"#{ENV['seraph_column_email']}"=> email,
			:"#{ENV['seraph_column_name']}"=> nome,
			:"#{ENV['seraph_column_cpf']}"=> cpf,
			:"#{ENV['seraph_column_username']}"=> login,
			:"#{ENV['seraph_column_password']}"=> senha,
			:"#{ENV['seraph_column_confirmation']}"=> senha,
		}
		user = ENV['seraph_table'].constantize.new( user_params )
		user.save
		return user
	end

	def self.logout
		"#{url}auth/logout/"
	end

	def self.login
		"#{url}/auth/login/?next=/auth/oauth2/authorize/skip/?client_id=#{ENV['seraph_client']}&response_type=code"
	end
end
