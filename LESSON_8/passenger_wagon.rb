# frozen_string_literal: true

class PassengerWagon < Wagon
  attr_reader :type, :occupied_seats

  def initialize(seats)
    super
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
