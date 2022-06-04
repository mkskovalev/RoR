# frozen_string_literal: true

class PassengerWagon < Wagon
  attr_reader :type

  def initialize
    @type = :passenger
  end
end
