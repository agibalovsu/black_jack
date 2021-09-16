# frozen_string_literal: true

require_relative 'instance_counter'

class Station
  NAME_FORMAT = /^[a-z]{3,15}$/i.freeze

  include InstanceCounter

  attr_accessor :name, :trains, :all_stations

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

  def validate!
    raise 'Название должно содержать не менее 3ёх символов' if name.length < 3
    raise 'Название не более 15 символов ЛАТИНИЦЫ' if name !~ NAME_FORMAT
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
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
