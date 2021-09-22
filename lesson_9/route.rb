# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'
require_relative 'station'
require_relative 'route'

class Route
  include InstanceCounter
  include Validation
  include Accessors

  strong_attr_accessor :first_station, Station
  strong_attr_accessor :last_station, Station 
  strong_attr_accessor :route, Route

  validate :first_station, :presence
  validate :last_station, :presence

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @list_interm_station = []
    register_instance
    validate!
  end

  # add interm station
  def add_interm_station(station)
    @list_interm_station << station
  end

  # delete interm station
  def delete_interm_station(station)
    if @list_interm_station.include?(station)
      @list_interm_station.delete(station)
    else
      puts "Станции #{station} нет в маршруте "
    end
  end

  def routes
    route = [@first_station, @list_interm_station, @last_station].flatten!
    route.each_with_index do |name_station, index|
    end
  end

  def all_stations_on_route
    route = [@first_station, @list_interm_station, @last_station].flatten!
  end
end
