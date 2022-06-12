# frozen_string_literal: true

require './modules/instance_counter'
require './modules/valid'

class Route
  include InstanceCounter
  include Valid

  attr_reader :stations, :first, :last

  @@routes = []

  def initialize(first, last)
    @first = first
    @last = last
    @stations = [first, last]
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
    @stations.delete(station) unless [@first, @last].include?(station)
  end

  def show_stations
    @stations.each { |station| puts station.name }
  end

  def validate!
    raise if first.nil? || last.nil?
  end
end
