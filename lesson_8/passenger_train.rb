# frozen_string_literal: true

require_relative 'train'

class PassengerTrain < Train
  def initialize(number)
    super(number, _type = 'passenger')
  end
end
