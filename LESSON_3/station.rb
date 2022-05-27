# frozen_string_literal: true

class Station
  attr_reader :name, :trains

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@stations.push(self)
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
end
