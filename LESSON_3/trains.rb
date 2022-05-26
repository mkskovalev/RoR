# frozen_string_literal: true

class Train
  attr_reader :speed, :current_station, :type, :wagons, :train_number, :route

  TRAIN_TYPE = %i[cargo passenger].freeze

  @@trains = []

  def initialize(train_number, type)
    @train_number = train_number
    @type = type
    @speed = 0
    @wagons = []
    @route = nil
    @@trains.push(self)

    raise 'Ошибка в типе поезда' unless TRAIN_TYPE.include?(@type)
  end

  def trains
    @@trains
  end

  def add_speed(speed)
    @speed = speed.to_i
  end

  def stop
    @speed = 0
  end

  def add_wagon
    if @type.equal?(:passenger) && @speed.zero?
      new_wagon = PassengerWagon.new
    elsif @type.equal?(:cargo) && @speed.zero?
      new_wagon = CargoWagon.new
    end
    @wagons.push(new_wagon)
  end

  def delete_wagon
    @wagons.delete(@wagons[-1])
  end

  def assign_route(route)
    @route = route
    @current_station = route.stations[0]
    @current_station.add_train(self)
    @station_index = 0
  end

  def move_forward
    stations_update(1) unless last_station?
  end

  def move_backward
    stations_update(-1) unless first_station?
  end

  def prev_station
    @route.stations[@station_index - 1] unless first_station?
  end

  def next_station
    @route.stations[@station_index + 1] unless last_station?
  end

  protected

  # Подметод метода move_*, не вызывается сам по себе

  def stations_update(step)
    @current_station.remove_train(self)
    @current_station = @route.stations[@station_index + step]
    @current_station.add_train(self)
    @station_index += step
  end

  # Вспомогательные методы для операций со станциями

  def first_station?
    @current_station == @route.stations[0]
  end

  def last_station?
    @current_station == @route.stations[-1]
  end
end
