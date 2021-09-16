# frozen_string_literal: true

require_relative 'company'

class Wagon
  include Company

  attr_accessor :type

  def initialize(type)
    @type = type
    validate!
  end

  def validate!
    raise 'Не указан тип вагона' if @type.nil?
    raise 'Не верно указан тип вагона, допустимые значения: cargo , passenger' if type != 'cargo' && type != 'passenger'
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end
end
