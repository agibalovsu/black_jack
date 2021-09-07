require_relative 'wagons.rb'
require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'company.rb'
require_relative 'instance_counter.rb'
require_relative 'cargo_wagons.rb'
require_relative 'passanger_wagons'

class Train

  NUMBER_FORMAT = /^[0-9a-z]{3}[.-]?[0-9a-z]{2}$/i

  include Company
  include InstanceCounter

  attr_reader  :current_station, :previous_station, :next_station
  attr_accessor :speed, :route, :wagons, :type, :number

  @@train_numbers = []
  
  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
    @wagons = []
    @@train_numbers << number
    register_instance
    validate!
  end

  def all_wagons_in_train(block)
    self.wagons.each_with_index {|wagon, i| block.call(wagon, i)}
  end

  def validate!
    raise "Не указан номер поезда" if @number.nil? #лишний метод из-за ArgimentError
    raise "Не верный формат номера поезда: верный формат ХХХХХ или ХХХ-ХХ" if number.to_s !~ NUMBER_FORMAT
    raise "Количество символов поезда не может быть менее 5 символов" if number.to_s.length < 5 && number.to_s.length >= 6
    raise "Не верно указан тип поезда" if type != "cargo" && type != "passenger"
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def self.find(number)
    if @@train_numbers.include?(number)
      puts "Поезд №#{number} найден"
    else
      puts "Поезд с номером #{number} не найден"
    end
  end

  def increase_speed(increase_speed)
    self.speed += increase_speed
    puts "Скорость увеличена на #{increase_speed} km/h текущая скорость #{@speed}"
  end

  def reduce_speed(reduce_speed)
    self.speed -= reduce_speed
    puts "Скорость уменьшена на #{reduce_speed} km/h текущая скорость #{@speed}"
  end

  def add_wagon(number)
    if type == "cargo" && self.speed == 0
      wagon = CargoWagon.new(number)
    elsif type == "passenger" && self.speed == 0
      wagon = PassangerWagon.new(number)
    end
    @wagons << wagon
    puts "Вагон добавлен к поезду"
    if self.speed != 0
      puts "Для прицепки вагонов необходимо остановить поезд"
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
