# frozen_string_literal: true
require './modules/validation'

class CargoWagon < Wagon
  include Validation

  attr_reader :type, :occupied_volume, :volume
  validate :volume, :presence
  validate :volume, :type, Integer

  def initialize(volume)
    super()
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
