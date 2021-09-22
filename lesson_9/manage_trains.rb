# frozen_string_literal: true

require_relative 'train'
require_relative 'route'
require_relative 'cargo_train'
require_relative 'passenger_train'

module ManageTrain
  attr_accessor :train, :route, :type, :wagon

  def manage_train
    train = text_interface(@trains)
    case text_interface(['Определить маршрут', 'Добавить вагон', 'Удалить вагон', 'Вывести список вагонов',
                         'Занять место или объем в вагоне'])
    when 0 then select_route(train)
    when 1 then add_wag(train)
    when 2 then remove_wag(train)
    when 3 then list_of_wag(train)
    when 4 then wagon = text_interface(train.wagons)
                occup_space(wagon)
                occup_place(wagon)
    end
  end

  def select_route(train)
    puts 'Выберите маршрут: '
    route = text_interface(@routes)
    train.train_on_route(route)
    puts "Поезду №#{train.number} определен маршрут"
  end

  def add_wag(train)
    case train.type
    when :cargo then print 'Введите номер вагона: '
                      number = gets.chomp
                      CargoWagon.new(number)
                      train.add_wagon(number)
    when :passenger then print 'Введите номер вагона: '
                          number = gets.chomp
                          PassengerWagon.new(number)
                          train.add_wagon(number)
    end
  end

  def remove_wag(train)
    wagon = text_interface(train.wagons)
    train.remove_wagon
    puts "#{wagon.number} вагон успешно отцеплен от поезда №#{train.number}"
  end

  def list_of_wag(train)
    block = lambda do |wag, _i|
      print "Номер вагона: #{wag.number} "
      print " Тип вагона: #{wag.type} "
      if train.type == :cargo
        puts " Объем вагона: #{wag.volume} m3  "
      else train.type == :passenger 
        puts " Kоличество свободных мест: #{wag.count_places}"
      end
    end
    train.all_wagons_in_train(block)
  end

  def occup_space(wagon)
    return unless wagon.type == 'cargo'

    puts 'Введите желаемый объем для заполнения: '
    volume = gets.chomp.to_i
    wagon.occupied_space(volume)
    if wagon.occ_space > wagon.volume
      puts "Перегруз#{wagon.free_space} m3"
    else
      puts "Груз успешно помещен в вагон занято: #{wagon.occ_space}, свободно #{wagon.free_space}"
    end
  end

  def occup_place(wagon)
    return unless wagon.type == 'passenger'

    wagon.occupied_places
    puts "Место занято, количество свободных мест #{wagon.free_places}"
    puts 'Вагон заполнен, выберите другой вагон' if wagon.free_places.zero?
  end
end
