require_relative "company.rb"


class CargoWagon 

  include Company

  attr_accessor :type, :volume, :number
  attr_reader :occ_space

  def initialize(number)
    @number = number
    @type = "cargo"
    @volume = 100
    @occ_space = 0
  end

  def occupied_space(volume)
    @occ_space += volume
  end

  def free_space
    @volume - @occ_space
  end
end
