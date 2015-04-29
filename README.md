# SeraphAuth

Gem de autenticação OAuth com seraph.defensoria.to.gov.br

## Instalação

Add em Gemfile:

```ruby
gem 'rest-client'
gem 'seraph_auth'
```

Execute:

    $ bundle install

Ou manualmente:

    $ gem install seraph_auth

## Configurando

configure as seguintes variáveis:
	#Client Seraph
	ENV['seraph_client'] = 'any client' 

	#Secret Seraph
    ENV['seraph_secret'] = 'any secret'

	#tabela onde estão guardados os usuários
    ENV['seraph_table'] = "User"

    #coluna onde está guardado o nome do usuário
    ENV['seraph_column_name'] = "name"

    #coluna onde está guardado o cpf do usuário
    ENV['seraph_column_cpf'] = "cpf" 

    #coluna onde está guardado o email do usuário
    ENV['seraph_column_email'] = "email" 

    #coluna onde está guardado o usuario do usuário
    ENV['seraph_column_username'] = "username" 

    #coluna onde está guardada a senha do usuário
    ENV['seraph_column_password'] = "password"

    #coluna onde está guardada o confirmação de senha do usuário
    ENV['seraph_column_confirmation'] = "password_confirmation"

## Exemplo com Devise

### Redirecionando Usuário para Login

em config/routes.rb
	Rails.application.routes.draw do
  		get "/users/sign_in" => "api_auth#redirect"

		unauthenticated :user do
		    devise_scope :user do
		      get "/" => "api_auth#redirect"
		    end
		end
	end

em controller:

	def redirect
		redirect_to SeraphAuth.auth_url
	end

### Callback

em controller:
	
	def entrar
		@user = SeraphAuth.login(params[:code])
		if @user[:error]
			flash[:alert] = @user[:error]
			redirect_to your_url 
		else
			sign_in_and_redirect @user, :event => :authentication
		end
	end

### Logout
	
em aplication_controller.rb

	def after_sign_out_path_for(resource_or_scope)
	    SeraphAuth.logout
	end



