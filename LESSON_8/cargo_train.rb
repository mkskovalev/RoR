# frozen_string_literal: true
require './modules/validation'

class CargoTrain < Train
  include Validation

  attr_reader :type
  validate :number, :presence
  validate :number, :format, /^[A-Za-z0-9]{3}-*[A-Za-z0-9]{2}$/

  def initialize(number)
    super
    @type = :cargo
  end
end
