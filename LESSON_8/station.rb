# frozen_string_literal: true

require './modules/instance_counter'
require './modules/validation'

class Station
  include InstanceCounter
  include Validation

  attr_accessor :name
  attr_reader :trains
  validate :name, :presence
  validate :name, :type, String

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@stations.push(self)
    register_instance
    validate!
  end

  def self.all
    @@stations
  end

  def add_train(train)
    @trains << train
  end

  def trains_by_type(value)
    @trains.select { |element| element.type == value }
  end

  def trains_count_by_type(value)
    @trains.count { |element| element.type == value }
  end

  def remove_train(train)
    @trains.delete(train)
  end

  def all_trains(&block)
    @trains.each(&block)
  end
end
