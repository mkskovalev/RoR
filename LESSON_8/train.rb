# frozen_string_literal: true

require './modules/manufacturer'
require './modules/instance_counter'
require './modules/accessors'
require './modules/validation'

class Train
  include Manufacturer
  include InstanceCounter
  include Acсessors
  include Validation

  attr_reader :speed, :current_station, :wagons, :number, :route
  attr_accessor_with_history :a, :b, :c
  validate :number, :presence
  validate :number, :format, /^[A-Za-z0-9]{3}-*[A-Za-z0-9]{2}$/

  @@trains = []

  def initialize(number)
    @number = number.to_s
    @speed = 0
    @wagons = []
    @route = nil
    validate!
    @@trains.push(self)
    register_instance
  end

  class << self
    def all
      @@trains
    end

    def find(num)
      @@trains.find { |obj| obj.number == num }
    end
  end   

  def add_speed(speed)
    @speed = speed.to_i
  end

  def stop
    @speed = 0
  end

  def add_wagon(object)
    @wagons << object if @type == object.type
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

  def all_wagons(&block)
    @wagons.each(&block)
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

  private_class_method :find
end
