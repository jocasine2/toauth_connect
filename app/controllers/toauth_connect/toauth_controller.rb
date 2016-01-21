module ToauthConnect
	class ToauthController < ApplicationController
		def entrar
			@user = ToauthConnect.login(params[:code])
			begin
				sign_in_and_redirect @user, :event => :authentication
			rescue
  				redirect_to '/500.html'  #Porta para redirecionar havendo erro
  			end
  		end

  		def redirect
  			redirect_to ToauthConnect.auth_url
  		end
  	end
end