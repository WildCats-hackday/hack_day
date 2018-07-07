#!/usr/bin/env ruby
require 'bunny'

puts "Entrando" 
connection = Bunny.new(automatically_recover: false)
connection.start
puts "Entrou"

channel = connection.create_channel
queue = channel.queue('carros')
puts "Escutando ...."
begin
  puts ' [*] Waiting for messages. To exit press CTRL+C'
  queue.subscribe(block: true) do |_delivery_info, _properties, body|
    puts " [x] Received #{body}"
  end
rescue Interrupt => _
  connection.close

  exit(0)
end
