# frozen_string_literal: true

require './route'
require './train'
require './wagon'
require './station'
require './passenger_train'
require './cargo_train'
require './passenger_wagon'
require './cargo_wagon'


begin
  tr1 = Train.new(nil)
rescue => e
  puts e
end

begin
  tr2 = Train.new(123)
rescue => e
  puts e
end

begin
  st = Station.new(123)
rescue => e
  puts e
end
