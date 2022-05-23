class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = [first_station, last_station]
  end

  def add_station(station)
    @stations[@stations.size] = @stations[-1]
    @stations[-2] = station
  end

  def remove_station(station)
    if station != @stations[0] && station != @stations[-1]
      @stations.delete(station)
    else
      puts "Нельзя удалить первую и последнюю станцию"
    end
  end

  def show_stations
    @stations.each { |station| puts station.station_name }
  end
end
