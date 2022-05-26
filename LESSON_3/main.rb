# frozen_string_literal: true

require './routes'
require './trains'
require './stations'
require './passenger_trains'
require './cargo_trains'
require './passenger_wagons'
require './cargo_wagons'

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

  def create_station
    puts 'Введите название станции:'
    name = gets.chomp.to_s
    @station = Station.new(name)
    @stations = @station.stations
    puts "Станция #{@station.name} создана"
    sleep 2
  end

  @first_last_stations = []

  def add_station_to_route(count)
    message = ['Выберите начальную станцию и введите ее номер:', 'Выберите конечную станцию и введите ее номер:']
    else_message = ['Нет станций для выбора начальной, давайте создадим:',
                    'Нет станций для выбора конечной, давайте создадим:']

    if @stations.nil?
      puts else_message[count]
      create_station
      @first_last_stations.insert(-1, @stations.last)
    else
      puts message[count]
      choose_station
      @first_last_stations.insert(-1, @selected_station)
    end
  end

  def choose_station
    @stations.each { |x| puts "#{@stations.index(x)} - #{x.name}" }
    puts "#{@stations.size} - Создать новую"
    @indx = gets.chomp.to_i

    create_station if @indx == @stations.size

    @selected_station = @stations[@indx]
  end

  def choose_route
    if @route.nil?
      puts 'Маршрутов нет. Сначала создайте маршрут!'
      sleep 2
    else
      puts 'Выберите маршрут и введите его номер:'
      @routes = @route.routes
      @routes.each { |value| puts "#{@routes.index(value)} - #{value.first_station.name}-#{value.last_station.name}" }
      selected_number = gets.chomp.to_i
      @selected_route = @routes[selected_number]
    end
  end

  def choose_train
    if @train.nil?
      puts 'Поездов нет. Сначала создайте поезд!'
      sleep 2
    else
      puts 'Выберите поезд и введите его номер:'
      trains = @train.trains
      trains.each { |x| puts "#{trains.index(x)} - Поезд №#{x.train_number}" }
      selected_number = gets.chomp.to_i
      @selected_train = trains[selected_number]
    end
  end

  def moving_train(mode)
    return if @train.nil?

    if @selected_train.route.nil?
      puts 'Cначала назначьте маршрут на этот поезд!'
    else
      case mode
      when :froward
        @selected_train.move_forward
      when :backward
        @selected_train.move_backward
      end
      puts "Переместили на станцию: #{@selected_train.current_station.name}"
    end
    sleep 2
  end

  case action
  when 1
    create_station

  when 2
    puts 'Введите номер поезда:'
    number = gets.chomp.to_s

    puts 'Введите выберите тип поезда и введите номер:'
    puts '1 - Пассажирский'
    puts '2 - Грузовой'
    passenger = gets.chomp.to_i

    case passenger
    when 1
      type = :passenger
    when 2
      type = :cargo
    end

    @train = Train.new(number, type)
    puts 'Поезд создан!'
    sleep 2

  when 3
    add_station_to_route(0)
    add_station_to_route(1)
    @route = Route.new(@first_last_stations[0], @first_last_stations[1])
    puts 'Маршрут создан!'
    sleep 2

  when 4
    choose_route
    sleep 2
    puts 'Выберите действие:'
    puts '1 - Добавить станцию'
    puts '2 - Удалить станцию'
    selected_action = gets.chomp.to_i

    case selected_action
    when 1
      puts 'Выберите станцию:'
      choose_station
      @selected_route.add_station(@selected_station)
      puts 'Станция добавлена!'

    when 2
      puts 'Выберите станцию и введите ее номер:'
      stat = @selected_route.stations
      stat.each { |x| puts "#{stat.index(x)} - #{x.name}" unless [stat[0], stat[-1]].include?(x) }
      @indx = gets.chomp.to_i
      @selected_station = stat[@indx]
      @selected_route.remove_station(@selected_station)
      puts 'Станция удалена!'

    else
      puts 'Введено неправильное значение'
    end
    sleep 2

  when 5
    choose_train
    unless @train.nil?
      choose_route
      unless @route.nil?
        @selected_train.assign_route(@selected_route)
        puts "Маршрут #{@selected_route.first_station.name}-#{@selected_route.last_station.name} назначен поезду №#{@selected_train.train_number}"
        sleep 2
      end
    end

  when 6
    choose_train
    @selected_train.add_wagon
    puts "У поезда #{@selected_train.train_number} вагонов: #{@selected_train.wagons.size}"
    sleep 2

  when 7
    choose_train
    unless @train.nil?
      @selected_train.delete_wagon
      puts "У поезда #{@selected_train.train_number} вагонов: #{@selected_train.wagons.size}"
      sleep 2
    end

  when 8
    choose_train
    moving_train(:froward)

  when 9
    choose_train
    moving_train(:backward)

  when 10
    @stations.each do |x|
      puts "Станция: #{x.name}, поезда:"
      if x.trains.empty?
        puts 'Нет поездов на станции'
      else
        x.trains.each { |t| puts t.train_number }
      end
    end
    sleep 2

  else
    puts 'Введено неправильное значение'
    sleep 2
  end
end
