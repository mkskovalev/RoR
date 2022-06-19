# frozen_string_literal: true

require './modules/instance_counter'
require './modules/validation'

class Route
  include InstanceCounter
  include Validation

  attr_reader :stations, :first, :last
  validate :first, :presence
  validate :last, :presence

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
end
