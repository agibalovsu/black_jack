# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'

class Station
  NAME_FORMAT = /^[a-z]{3,15}$/i.freeze

  include InstanceCounter
  include Validation

  attr_accessor :name, :trains, :all_stations

  validate :name, :format, NAME_FORMAT
  validate :name, :presence

  @@all_stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@all_stations << name
    register_instance
    validate!
  end

  def self.all
    puts @@all_stations
  end

  def add_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def trains_by_type(type)
    result = []
    @trains.each { |train| result << train if train.type == type }
    result
  end

  def all_trains_on_station(block)
    trains.each { |train| block.call(train) }
  end
end
