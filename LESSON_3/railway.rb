require './routes.rb'
require './trains.rb'
require './stations.rb'

station_1 = Station.new("moscow")
station_2 = Station.new("himki")
station_3 = Station.new("zelenograd")
station_4 = Station.new("lubertsy")
station_5 = Station.new("odintsovo")
station_6 = Station.new("hovrino")
station_7 = Station.new("ostankino")

train_1 = Train.new(111, :cargo, 12)
train_2 = Train.new(117, :cargo, 7)
train_3 = Train.new(123, :passenger, 5)
train_4 = Train.new(142, :passenger, 7)

route_1 = Route.new(station_1, station_2)
route_2 = Route.new(station_3, station_4)
route_3 = Route.new(station_5, station_1)

puts "Созданные поезда:"
puts train_1, train_2, train_3, train_4
puts "\n"

puts "Созданные маршруты:"
puts route_1, route_2, route_3
puts "\n"

puts "Добавили станции в route_1:"
puts route_1.add_station(station_6)
puts route_1.add_station(station_7)
puts "\n"

puts "Показать все станции route_1:"
route_1.show_stations
puts "\n"

puts "Удаляем станцию из route_1:"
route_1.remove_station(station_7)
route_1.show_stations
puts "\n"

puts "train_1 набирает скорость:"
train_1.add_speed(20)
puts train_1.speed
puts "\n"

puts "Останавливаем train_1:"
train_1.stop
puts train_1.speed
puts "\n"

puts "прицепляем/отцепляем вагоны train_1:"
puts train_1.wagons_count
train_1.add_wagon
puts train_1.wagons_count
train_1.delete_wagon
puts train_1.wagons_count
puts "\n"

train_1.assign_route(route_1)
train_3.assign_route(route_1)

puts "станции в маршруте:"
puts "предыдущая - #{train_1.prev_station}"
puts "текущая - #{train_1.current_station}"
puts "следующая - #{train_1.next_station}"
puts "\n"

puts "поезда на станции station_1:"
puts station_1.trains
puts "\n"

puts "поезда по типам на станции station_1:"
puts station_1.trains_by_type(:cargo)
puts station_1.trains_count_by_type(:cargo)
puts "\n"

puts "перемещение:"
puts train_1.move_backward
puts train_1.move_forward

puts "станции в маршруте:"
puts "предыдущая - #{train_1.prev_station}"
puts "текущая - #{train_1.current_station.name}"
puts "следующая - #{train_1.next_station}"
puts "\n"
