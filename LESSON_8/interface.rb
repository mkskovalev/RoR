# frozen_string_literal: true

require './route'
require './train'
require './wagon'
require './station'
require './passenger_train'
require './cargo_train'
require './passenger_wagon'
require './cargo_wagon'
require './modules/validation'

class Interface
  include Validation

  attr_reader :input
  validate :input, :presence

  def initialize
    @first_last_stations = []
    @input = nil
  end

  def run
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
      puts '11 - Список вагонов у поезда'
      puts '12 - Список поездов на станции'
      puts '0 - Для завершения'

      @input = gets.chomp.to_i

      break if input.zero?

      def find_command
        {
          1 => :create_station,
          2 => :create_train,
          3 => :create_route,
          4 => :edit_route,
          5 => :route_to_train,
          6 => :add_wagon_to_train,
          7 => :delete_wagon_from_train,
          8 => :move_train_forward,
          9 => :move_train_backward,
          10 => :stations_and_trains_list,
          11 => :show_wagons,
          12 => :show_trains_on_station
        }      
      end

      send find_command.fetch(input.to_i, "Неверное значение")
    end
  end

  private

  def create_station
    puts 'Введите название станции:'
    @input = gets.chomp.to_s
    @station = Station.new(@input)
    puts "Станция #{@station.name} создана"
  rescue => e
    puts e
    retry
  end

  def add_station_to_route(count)
    message = ['Выберите начальную станцию и введите ее номер:', 'Выберите конечную станцию и введите ее номер:']

    if Station.all.empty?
      puts 'Нет станций, давайте создадим!'
      create_station
      @first_last_stations << Station.all.last
    else
      puts message[count]
      choose_station
      @first_last_stations << Station.all[@indx]
    end
  end

  def choose_station
    Station.all.each { |x| puts "#{Station.all.index(x)} - #{x.name}" }
    puts "#{Station.all.size} - Создать новую"
    @indx = gets.chomp.to_i

    create_station if @indx == Station.all.size
  end

  def choose_route
    if Route.all.empty?
      puts 'Маршрутов нет. Сначала создайте маршрут!'
    else
      puts 'Выберите маршрут и введите его номер:'
      Route.all.each { |v| puts "#{Route.all.index(v)} - #{v.first.name}-#{v.last.name}" }
      input = gets.chomp.to_i
      @selected_route = Route.all[input]
    end
  end

  def choose_train
    if Train.all.empty?
      puts 'Поездов нет. Сначала создайте поезд!'
    else
      puts 'Выберите поезд и введите его номер:'
      Train.all.each { |x| puts "#{Train.all.index(x)} - Поезд №#{x.number}" }
      input = gets.chomp.to_i
      @selected_train = Train.all[input]
    end
  end

  def moving_train(mode)
    return if Train.all.empty?

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
  end

  def create_train
    puts 'Введите номер поезда:'
    number = gets.chomp.to_s

    puts 'Введите выберите тип поезда и введите номер:'
    puts '1 - Пассажирский'
    puts '2 - Грузовой'
    type = gets.chomp.to_i

    case type
    when 1
      @train = PassengerTrain.new(number)
    when 2
      @train = CargoTrain.new(number)
    else
      puts 'Введено неверное значение!'
    end

    puts 'Поезд создан!'
  rescue StandardError
    puts 'Неверный формат номера поезда. Попробуйте еще раз.'
    retry
  end

  def create_route
    add_station_to_route(0)
    add_station_to_route(1)
    @route = Route.new(@first_last_stations[0], @first_last_stations[1])
    puts 'Маршрут создан!'
  end

  def edit_route
    choose_route
    puts 'Выберите действие:'
    puts '1 - Добавить станцию'
    puts '2 - Удалить станцию'
    input = gets.chomp.to_i

    case input
    when 1
      puts 'Выберите станцию:'
      choose_station
      @selected_route.add_station(Station.all[@indx])
      puts 'Станция добавлена!'

    when 2
      puts 'Выберите станцию и введите ее номер:'
      stat = @selected_route.stations
      stat.each { |x| puts "#{stat.index(x)} - #{x.name}" unless [stat[0], stat[-1]].include?(x) }
      input = gets.chomp.to_i
      @selected_station = stat[input]
      @selected_route.remove_station(@selected_station)
      puts 'Станция удалена!'

    else
      puts 'Введено неправильное значение'
    end
  end

  def route_to_train
    choose_train
    
    unless Train.all.empty?
      choose_route
      unless Route.all.empty?
        @selected_train.assign_route(@selected_route)
        puts "Маршрут #{@selected_route.first.name}-#{@selected_route.last.name} назначен поезду №#{@selected_train.number}"
      end
    end
  end

  def add_wagon_to_train
    choose_train

    if @selected_train.type.equal?(:passenger) && @selected_train.speed.zero?
      puts 'Укажите кол-во мест в вагоне:'
      input = gets.chomp.to_i
      new_wagon = PassengerWagon.new(input)
    elsif @selected_train.type.equal?(:cargo) && @selected_train.speed.zero?
      puts 'Укажите объем вагона в куб. м.:'
      input = gets.chomp.to_i
      new_wagon = CargoWagon.new(input)
    end

    @selected_train.add_wagon(new_wagon)
    puts "У поезда #{@selected_train.number} вагонов: #{@selected_train.wagons.size}"
  end

  def delete_wagon_from_train
    choose_train
    unless Train.all.empty?
      @selected_train.delete_wagon
      puts "У поезда #{@selected_train.number} вагонов: #{@selected_train.wagons.size}"
    end
  end

  def move_train_forward
    choose_train
    moving_train(:froward)
  end

  def move_train_backward
    choose_train
    moving_train(:backward)
  end

  def stations_and_trains_list
    Station.all.each do |x|
      puts "Станция: #{x.name}, поезда:"
      if x.trains.empty?
        puts 'Нет поездов на станции'
      else
        x.trains.each { |t| puts t.number }
      end
    end
  end

  def show_wagons
    choose_train
    @number = 0
    case @selected_train.type
    when :passenger
      @selected_train.all_wagons do |w|
        puts "Вагон №#{@number += 1}, тип: #{w.type}, св. мест: #{w.free_seats}, занято мест: #{w.occupied_seats}"
      end
    when :cargo
      @selected_train.all_wagons do |w|
        puts "Вагон №#{@number += 1}, тип: #{w.type}, св. объем: #{w.free_volume}, занято объема: #{w.occupied_volume}"
      end
    end
  end

  def show_trains_on_station
    choose_station
    Station.all[@indx].all_trains { |t| puts "Поезд №#{t.number}, тип: #{t.type}, вагонов: #{t.wagons.size}" }
  end
end
