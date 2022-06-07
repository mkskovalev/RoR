# frozen_string_literal: true

class CargoWagon < Wagon
  attr_reader :type, :occupied_volume

  def initialize(volume)
    super
    @type = :cargo
    @volume = volume
    @occupied_volume = 0
  end

  def occupy_volume(count)
    @occupied_volume += count
  end

  def free_volume
    @volume - @occupied_volume
  end
end
