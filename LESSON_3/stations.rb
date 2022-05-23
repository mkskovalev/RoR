class Station
  attr_reader :station_name

  def initialize(station_name)
    @station_name = station_name
    @trains = []
  end

  def get_train(train)
    @trains << train
  end

  def show_trains
    @trains.each { |train| puts train }
  end

  def show_trains_by_type
    types = Hash.new(0)
    @trains.each { |train| types.store(train.type, types[train]+1) }
    types.each { |key, value| puts "#{key} - #{value}"}
  end

  def remove_train(train)
    @trains.delete(train)
  end
end
