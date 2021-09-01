require_relative 'instance_counter.rb'

class Route

  NAME_FORMAT = /^[a-z]{3,15}$/i

  include InstanceCounter

  attr_reader :first_station, :last_station
  

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @list_interm_station = [] # список(массив) промежуточных станций
    register_instance
    validate!
  end

  def validate!
    raise "Не введено имя начальной или конечной станции" if first_station.nil? && last_station.nil?  #лишний метод из-за ArgimentError
    raise "Название должно состоять не менее чем из двух символов" if first_station.length < 3 && last_station.length < 3
    raise "Название может включать не более 15 символов ЛАТИНИЦЫ" if first_station !~ NAME_FORMAT && last_station !~ NAME_FORMAT
  end
  
  def valid?
    validate!
    true
  rescue
    false
  end

  def add_interm_station(station) # добавляем промежуточную станцию
    @list_interm_station << station 
  end

  def delete_interm_station(station) # удаляем промежуточную станцию
    if @list_interm_station.include?(station)
      @list_interm_station.delete("#{station}")
    else
      puts "Станции #{station} нет в маршруте "
    end
  end
  
  def route
    route = [@first_station, @list_interm_station, @last_station].flatten!
    route.each_with_index do |name_station, index|
    end
  end
  
  def all_stations_on_route
    route = [@first_station, @list_interm_station, @last_station].flatten!
  end
end
