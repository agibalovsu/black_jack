# frozen_string_literal: true

require_relative 'train'

class PassengerTrain < Train
  TRAIN_NUMBER = /^[0-9a-z]{3}[.-]?[0-9a-z]{2}$/i.freeze

  validate :number, :presence
  validate :number, :format, TRAIN_NUMBER

  def initialize(number)
    super(number, _type = 'passenger')
    validate!
  end
end
