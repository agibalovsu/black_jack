require_relative "company.rb"

class Wagon

  include Company

  attr_accessor :type

  def initialize(type)
    @type = type
    validate!
  end

  def validate!
    raise "Не указан тип вагона" if @type.nil? #лишний метод из-за ArgumentError
    raise "Не верно указан тип вагона, допустимые значения: cargo , passenger" if type != "cargo" && type != "passenger"
  end

  def valid?
    validate!
    true
  rescue
    false
  end
end