# frozen_string_literal: true

require './modules/manufacturer'
require './modules/valid'

class Wagon
  include Manufacturer
  include Valid

  def initialize
    validate!
  end

  def validate!
    raise if @type.nil?
  end
end
