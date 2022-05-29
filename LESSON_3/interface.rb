require './route'
require './train'
require './station'
require './passenger_train'
require './cargo_train'
require './passenger_wagon'
require './cargo_wagon'

class Interface
  attr_reader :create_station
  @@first_last_stations = []

  def create_station
    puts 'Введите название станции:'
    name = gets.chomp.to_s
    @station = Station.new(name)
    puts "Станция #{@station.name} создана"
  end

  def add_station_to_route(count)
    message = ['Выберите начальную станцию и введите ее номер:', 'Выберите конечную станцию и введите ее номер:']
    else_message = ['Нет станций для выбора начальной, давайте создадим:',
                    'Нет станций для выбора конечной, давайте создадим:']

    if Station.all.empty?
      puts else_message[count]
      create_station
      @@first_last_stations << Station.all.last
    else
      puts message[count]
      choose_station
      @@first_last_stations << Station.all[@indx]
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
      Route.all.each do |value|
        puts "#{Route.all.index(value)} - #{value.first_station.name}-#{value.last_station.name}"
      end
      selected_number = gets.chomp.to_i
      @selected_route = Route.all[selected_number]
    end
  end

  def choose_train
    if Train.all.empty?
      puts 'Поездов нет. Сначала создайте поезд!'
    else
      puts 'Выберите поезд и введите его номер:'
      Train.all.each { |x| puts "#{Train.all.index(x)} - Поезд №#{x.number}" }
      selected_number = gets.chomp.to_i
      @selected_train = Train.all[selected_number]
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
    end

    puts 'Поезд создан!'
  end

  def create_route
    add_station_to_route(0)
    add_station_to_route(1)
    @route = Route.new(@@first_last_stations[0], @@first_last_stations[1])
    puts 'Маршрут создан!'
  end

  def edit_route
    choose_route
    puts 'Выберите действие:'
    puts '1 - Добавить станцию'
    puts '2 - Удалить станцию'
    selected_action = gets.chomp.to_i

    case selected_action
    when 1
      puts 'Выберите станцию:'
      choose_station
      @selected_route.add_station(Station.all[@indx])
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
  end

  def route_to_train
    choose_train
    unless Train.all.empty?
      choose_route
      unless Route.all.empty?
        @selected_train.assign_route(@selected_route)
        puts "Маршрут #{@selected_route.first_station.name}-#{@selected_route.last_station.name} назначен поезду №#{@selected_train.number}"
      end
    end
  end

  def add_wagon_to_train
    choose_train

    if @selected_train.type.equal?(:passenger) && @selected_train.speed.zero?
      new_wagon = PassengerWagon.new
    elsif @selected_train.type.equal?(:cargo) && @selected_train.speed.zero?
      new_wagon = CargoWagon.new
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
      puts '999 - Для завершения'

      action = gets.chomp.to_i

      break if action == 999

      case action
      when 1
        self.create_station

      when 2
        self.create_train

      when 3
        self.create_route

      when 4
        self.edit_route

      when 5
        self.route_to_train

      when 6
        self.add_wagon_to_train

      when 7
        self.delete_wagon_from_train

      when 8
        self.move_train_forward

      when 9
        self.move_train_backward

      when 10
        self.stations_and_trains_list

      else
        puts 'Введено неправильное значение'
      end
    end
  end
end
