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
		user = ENV['seraph_table'].constantize.new
		user.send(ENV['seraph_column_email']) = email
		user.send(ENV['seraph_column_name']) = nome
		user.send(ENV['seraph_column_cpf']) = cpf
		user.send(ENV['seraph_column_usermame']) = login
		user.send(ENV['seraph_column_password']) = senha
		user.send(ENV['seraph_column_confirmation']) = senha
		user.save
		return user
	end
end
