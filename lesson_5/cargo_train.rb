require_relative 'train.rb'

class CargoTrain < Train

  def initialize(number)
    super(number, type = "cargo")
  end
end

   