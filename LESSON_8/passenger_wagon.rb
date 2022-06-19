# frozen_string_literal: true
require './modules/validation'

class PassengerWagon < Wagon
  include Validation

  attr_reader :type, :occupied_seats
  validate :seats, :presence
  validate :seats, :type, Integer

  def initialize(seats)
    super()
    @seats = seats
    @type = :passenger
    @occupied_seats = 0
  end

  def occupy_seat
    @occupied_seats += 1
  end

  def free_seats
    @seats - @occupied_seats
  end
end
