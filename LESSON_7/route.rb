# frozen_string_literal: true
require './modules/instance_counter'
require './modules/valid'

class Route
  include InstanceCounter
  include Valid

  attr_reader :stations, :first_station, :last_station

  @@routes = []

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = [first_station, last_station]
    @@routes.push(self)
    register_instance
    validate!
  end

  def self.all
    @@routes
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    @stations.delete(station) unless [@first_station, @last_station].include?(station)
  end

  def show_stations
    @stations.each { |station| puts station.name }
  end

  def validate!
    raise if first_station == nil || last_station == nil
  end
end
