require_relative 'wagons.rb'
require_relative 'station.rb'
require_relative 'route.rb'


class Train

  attr_reader  :current_station, :previous_station, :next_station
  attr_accessor :speed, :route, :wagons, :type, :number
  
  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
    @wagons = []
  end

  def increase_speed(increase_speed)
    self.speed += increase_speed
    puts "Скорость увеличена на #{increase_speed} km/h текущая скорость #{@speed}"
  end

  def reduce_speed(reduce_speed)
    self.speed -= reduce_speed
    puts "Скорость уменьшена на #{reduce_speed} km/h текущая скорость #{@speed}"
  end

  def add_wagon(wagon)
    wagon = Wagon.new(type)
    if type == @type && @speed == 0
      @wagons << wagon
      puts "Вагон добавлен к поезду"
    elsif self.speed != 0
      puts "Для прицепки вагонов необходимо остановить поезд"
    elsif type != @type
      puts "Этот тип вагона нельзя прицепить к этому поезду"
    end
  end

  def list_wagon
    puts "У поезда сейчас #{@wagons.size} вагонов"
  end

  def remove_wagon
    if @speed == 0
      @wagons.pop()
      puts "Отцеплен вагон текущее количество вагонов: #{@wagons.size}"
    else
      puts "Отцепка, прицепка вагонов на ходу запрещена"
    end
  end

  def set_train_on_route(route)
    @route = route
    @current_station = route.all_stations_on_route[0] 
    @current_station.add_train(self) 

  def move_forward
    number_current_station = route.all_stations_on_route.index(@current_station)
    size = route.all_stations_on_route.size
    if number_current_station != size - 1 
      @current_station.send_train(self)
      number_current_station += 1
    else
      puts "Конечная станция поезд дальше не идет"
    end
    @current_station = route.all_stations_on_route[number_current_station]
    @current_station.add_train(self)  
  end

  def move_backward
    number_current_station = route.all_stations_on_route.index(@current_station)
    if number_current_station != 0
      @current_station.send_train(self)
      number_current_station -= 1
    else
      puts "Конечная станция поезд дальше не идет"
    end
    @current_station = route.all_stations_on_route[number_current_station]
    @current_station.add_train(self) 
  end
  end
end

