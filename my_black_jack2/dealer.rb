# frozen_string_literal: true

class User
  attr_accessor :name, :money, :score

  def initialize(name = 'dealer')
    @money = 100
    @name = name
  end

  def bet!
    @money -= 10
  end
end
