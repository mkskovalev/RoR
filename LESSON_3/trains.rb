class Train
  attr_reader :speed, :wagons_count, :current_station, :type

  def initialize(train_number, type, wagons_count)
    @train_number = train_number
    @type = type
    @wagons_count = wagons_count
    @route = "Нет маршрута"
  end

  def add_speed(speed)
    @speed = speed
  end

  def stop
    @speed = 0
  end

  def wagons_action
    if @speed == 0
      @wagons_count += @x
    else 
      puts "Сначала остановите поезд!" 
    end
  end

  def add_wagon
    @x = 1
    wagons_action
  end

  def delete_wagon
    @x = -1
    wagons_action
  end

  def get_route(route)
    @route = route
    @current_station = route.stations[0]
    @current_station.get_train(self)
    @station_index = 0
  end

  def move_forward
    if last_station == false
      @x = 1
      stations_update
    else
      "Последняя станция, двигаться вперед невозможно"
    end
  end

  def move_backward
    if first_station == false
      @x = -1
      stations_update
    else
      "Первая станция, двигаться назад невозможно"
    end    
  end

  def stations_update
    @current_station.remove_train(self)
    @current_station = @route.stations[@station_index+@x]
    @current_station.get_train(self)
    @station_index += @x
  end

  def first_station
    @current_station == @route.stations[0]
  end

  def last_station
    @current_station == @route.stations[-1]
  end

  def prev_station
    if first_station == true
      "Нет предыдущей станции"
    else
      @route.stations[@station_index-1]
    end
  end

  def next_station
    if last_station == true
      "Нет следующей станции"
    else
      @route.stations[@station_index+1]
    end    
  end
end
