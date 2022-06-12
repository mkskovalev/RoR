# frozen_string_literal: true

module Manufacturer
  attr_reader :manufacturer

  def add_manufacturer(name)
    @manufacturer = name
  end
end
