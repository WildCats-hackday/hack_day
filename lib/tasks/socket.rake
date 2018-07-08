require 'socket'
namespace :socket do
  desc "server socker"
  task server_task: :environment do  
    server = TCPServer.open(3001)
    loop { 
      client = server.accept     
      msg_cliente = client.recvfrom( 10000 ) 
      puts  "Mensagem do cliente: #{msg_cliente}" 
      client.puts "Ola cliente eu, o servidor, recebi sua mensagem"
      client.close # fecha conexão
    }
  end

end
