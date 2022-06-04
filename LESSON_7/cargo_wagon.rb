# frozen_string_literal: true

class CargoWagon < Wagon
  attr_reader :type

  def initialize
    @type = :cargo
  end
end
