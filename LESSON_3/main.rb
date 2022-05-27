# frozen_string_literal: true

require './route'
require './train'
require './station'
require './passenger_train'
require './cargo_train'
require './passenger_wagon'
require './cargo_wagon'
require './interface'

loop do
  puts 'Выберите действие и введите номер:'
  puts '1 - Создать станцию'
  puts '2 - Создать поезд'
  puts '3 - Cоздать маршрут'
  puts '4 - Редактировать маршрут'
  puts '5 - Назначить маршрут поезду'
  puts '6 - Добавить вагон к поезду'
  puts '7 - Отцепить вагон от поезда'
  puts '8 - Переместить поезд вперед'
  puts '9 - Переместить поезд назад'
  puts '10 - Список станций и поездов'
  puts '999 - Для завершения'

  action = gets.chomp.to_i

  break if action == 999

  run_method = Interface.new

  case action
  when 1
    run_method.create_station

  when 2
    run_method.create_train

  when 3
    run_method.create_route

  when 4
    run_method.edit_route

  when 5
    run_method.route_to_train

  when 6
    run_method.add_wagon_to_train

  when 7
    run_method.delete_wagon_from_train

  when 8
    run_method.move_train_forward

  when 9
    run_method.move_train_backward

  when 10
    run_method.stations_and_trains_list

  else
    puts 'Введено неправильное значение'
  end
end
