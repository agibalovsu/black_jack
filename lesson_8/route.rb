# frozen_string_literal: true

require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_reader :first_station, :last_station
  attr_accessor :route

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @list_interm_station = []
    register_instance
    validate!
  end

  def validate!
    raise 'Не введено имя начальной или конечной станции' if first_station.nil? && last_station.nil?
    return unless first_station.to_s.length < 3 && last_station.to_s.length < 3

    raise 'Название должно состоять не менее чем из двух символов'
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  # add interm station
  def add_interm_station(station)
    @list_interm_station << station
  end

  # delete interm station
  def delete_interm_station(station)
    if @list_interm_station.include?(station)
      @list_interm_station.delete(station.to_s)
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
    self.route = [@first_station, @list_interm_station, @last_station].flatten!
  end
end
