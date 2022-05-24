class Train
  attr_reader :speed, :wagons_count, :current_station, :type

  TRAIN_TYPE = %i[cargo passenger].freeze

  def initialize(train_number, type, wagons_count)
    @train_number = train_number
    @type = type
    @wagons_count = wagons_count
    @route = "Нет маршрута"

    raise "Ошибка в типе поезда" unless TRAIN_TYPE.include?(@type)
  end

  def add_speed(speed)
    @speed = speed
  end

  def stop
    @speed = 0
  end

  def add_wagon
    wagons_action(1)
  end

  def delete_wagon
    wagons_action(-1)
  end

  def wagons_action(count)
    if @speed == 0
      @wagons_count += count
    else 
      puts "Сначала остановите поезд!" 
    end
  end  

  def assign_route(route)
    @route = route
    @current_station = route.stations[0]
    @current_station.add_train(self)
    @station_index = 0
  end

  def move_forward
    if last_station?
      "Последняя станция, двигаться вперед невозможно"
    else
       stations_update(1)     
    end
  end

  def move_backward
    if first_station?
      "Первая станция, двигаться назад невозможно"
    else
      stations_update(-1)
    end    
  end

  def stations_update(step)
    @current_station.remove_train(self)
    @current_station = @route.stations[@station_index + step]
    @current_station.add_train(self)
    @station_index += step
  end

  def first_station?
    @current_station == @route.stations[0]
  end

  def last_station?
    @current_station == @route.stations[-1]
  end

  def prev_station
    if first_station?
      "Нет предыдущей станции"
    else
      @route.stations[@station_index - 1]
    end
  end

  def next_station
    if last_station?
      "Нет следующей станции"
    else
      @route.stations[@station_index + 1]
    end    
  end
end
