# frozen_string_literal: true

require_relative 'manage_trains'
require_relative 'route'
require_relative 'manage_route'
require_relative 'manage_textinterface'

class TextInterface
  include ManageTrain
  include ManageRoute
  include ManageTextInterface

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @menu_bar = MAIN_MENU_ITEMS
  end

  def run
    system 'clear'
    loop do
      run_action(@menu_bar)
    end
  end

  def interface
    text_interface(items)
    format_item(item)
    print_items(items)
    select_item(items)
    run_action(actions, *args)
  end

  # create stations
  def create_station
    print 'Введите название станции: '
    station = Station.new(gets.chomp.capitalize)
    @stations << station
    system 'clear'
    puts 'Станция создана!'
  end

  # create train
  def create_train
    case text_interface(['Грузовой поезд', 'Пассажирский поезд'])
    when 0
      print 'Введите номер поезда: '
      train = CargoTrain.new(gets.chomp.capitalize)
    when 1
      print 'Введите номер поезда: '
      train = PassengerTrain.new(gets.chomp.capitalize)
    end

    @trains << train
    puts 'Поезд создан!'
  end

  # create route
  def create_route
    puts 'Выберите первую станцию маршрута:'
    first_station = text_interface(@stations)
    puts 'Выберите конечную станцию маршрута:'
    last_station = text_interface(@stations)

    route = Route.new(first_station, last_station)
    @routes << route

    puts "Маршрут #{first_station.name} >>> #{last_station.name} успешно создан"
  end

  def manage_routes
    manage_route
  end

  def manage_trains
    manage_train
  end

  def move_train
    puts 'Выберите поезд: '
    train = text_interface(@trains)
    case text_interface(%w[Вперед Назад])
    when 0
      train.move_forward
      puts 'Поезд продвинулся на одну станцию вперед'
    when 1
      train.move_backward
      puts 'Поезд продвинулся на одну станцию назад'
    end
  end

  def station_info
    station = text_interface(@stations)

    block = lambda do |train|
      print "Номер поезда: #{train.number} "
      print " тип поезда: #{train.type} "
      puts " количество вагонов: #{train.wagons.size}"
    end
    station.all_trains_on_station(block)

    print 'Нажмите Enter для выхода.'
    gets
    system 'clear'
  end
end
