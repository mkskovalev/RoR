# frozen_string_literal: true

require './modules/instance_counter'
require './modules/valid'

class Station
  include InstanceCounter
  include Valid

  attr_reader :name, :trains

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

  def validate!
    raise 'Слишком короткое название' if name.length < 2
    raise 'Использование специальных символов запрещено' if name !~ /^[A-Za-z0-9.&]*\z/
  end
end
