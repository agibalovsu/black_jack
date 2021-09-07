require_relative "company.rb"

class PassangerWagon < Wagon

  include Company

  attr_accessor :type, :count_places, :number
  attr_reader :occ_places

  def initialize(number)
    @number = number
    @type = "passenger"
    @count_places = 30
    @occ_places = 0
  end

  def occupied_places
    @occ_places +=1
  end

  def free_places
    @count_places - @occ_places
  end
end
