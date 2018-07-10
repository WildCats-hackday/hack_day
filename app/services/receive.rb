#!/usr/bin/env ruby
require 'bunny'
require 'active_record'
require_relative '../models/car'

ActiveRecord::Base.establish_connection(
  :adapter  => "postgresql",
  :host     => "localhost",
  :username => "postgres",
  :password => "123456",
  :database => "hack_day_development"
)

connection = Bunny.new
connection.start

channel = connection.create_channel
exchange = channel.fanout('kiev')
queue = channel.queue('kiev.taxis', exclusive: true)

queue.bind(exchange)

puts ' [*] Waiting for logs. To exit press CTRL+C'

begin
  queue.subscribe(block: true) do |_delivery_info, _properties, body|
    res = body.split(",")
    puts "========BEGIN======="

    puts "Data: #{res.first}\nLat: #{res[1]}\nLog: #{res.last}"
    puts " [x] Received #{body}"
    @car = Car.first
    @car.data = res[0]
    @car.log = res[1]
    @car.lat = res[2]
    @car.save!
    
    puts "=======END=========="
  end
rescue Interrupt => _
  channel.close
  connection.close
end