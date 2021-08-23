class Route

#1 Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции 
#указываются при создании маршрута, а промежуточные могут добавляться между ними.
#2 Может добавлять промежуточную станцию в список
#3 Может удалять промежуточную станцию из списка
#4 Может выводить список всех станций по порядку от начальной до конечной

  attr_reader :first_station, :last_station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @list_interm_station = [] # список(массив) промежуточных станций
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
