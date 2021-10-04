# frozen_string_literal: true

class Card
  attr_reader :name, :lear, :value

  def initialize(name, lear, value)
    @name = name
    @lear = lear
    @value = value
  end
end
