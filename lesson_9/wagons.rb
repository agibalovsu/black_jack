# frozen_string_literal: true

require_relative 'company'

class Wagon
  include Company

  attr_accessor :type

  def initialize(type)
    @type = type 
  end
end
