ToauthConnect.configuration do |config|
  config.client_id  = "client_id" #ID de Cliente gerado no Toauth
  config.client_secret  = "client_secret" #Chave secreta gerada no Toauth
  config.domain_default  = "domain_default" #Domnio padrão
  config.url_redirect_production  = "url_redirect_production" #URL de Redirecionamento em produção
  config.url_redirect_dev  = "http://localhost:3000/toauth" #Url de redirecionamento em desenvolvimento
  config.user_table  = "user_table" #Nome da tabela contendo o Usuário
  config.column_email  = "column_email" #Coluna da tabela contendo o email
  config.column_token  = "colum_token" #Coluna da tabela contendo o token
  config.column_name  = "column_name" #Coluna da tabela contendo o nome
  config.column_cpf  = "column_cpf" #Coluna da tabela contendo o cpf
  config.column_password  = "column_password" #Coluna da tabela contendo o password
  config.column_password_confirmation  = "column_password_confirmation" #Coluna da tabela contendo a confirmação de password
end