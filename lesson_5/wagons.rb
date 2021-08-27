require_relative "company.rb"
require_relative "company.rb"

class Wagon

  include Company

  attr_reader :type
  def initialize(type)
    @type = type
  end
end
