class TextInterface
  def initialize
    @stations = []
    @trains = []
    @routes = []
    

    # пункты основного меню
    @menu_bar = [
      "Создать станцию",
      "Создать поезд",
      "Создать маршрут",
      "Управление маршрутами",
      "Управление поездами",
      "Движение поездов",
      "Информация о станциях и поездах на них"
    ]
  end

  #запуск программы
  def run
    system "clear"
    loop do
      case text_interface(@menu_bar)
      when 0 
        create_station()
      when 1  
        create_train()
      when 2  
        create_route()
      when 3  
        manage_routes()
      when 4  
        manage_trains()
      when 5 
        move_train()
      when 6 
        station_info()
      end
    end
  end
  
  # текстовый интерфейс
  def text_interface(items)

    puts ""                                                                                   
  
    choice = 0;
    loop do
      items.each_with_index do |item, i|
        case item
        when Train || CargoTrain || PassengerTrain then item = item.number                   
        when Station then item = item.name                                                   
        when Route then item = "#{item.route.first.name} >>>> #{item.route.last.name}"   
        end
        puts "#{i+1}. #{item}"                                                                
      end
      
      # выбор пункта
      puts "" 
                                                                                     
      print "Выберите значение: "
      choice = gets.chomp.to_i - 1                                                            
      
      #очищаем экран
      system "clear"
  
      
      if choice < 0 || choice >= items.length
        puts"Пожалуйста, выберите значение из списка"
      else
        break
      end
    end
  
    #возвращаем результат выбора
    case items[choice]
    when String then return choice   
    else items[choice]        
    end
  end

  # создание станций
  def create_station
    print "Введите название станции: "
    station = Station.new(gets.chomp.capitalize)
    @stations << station

    system "clear"
    puts "Станция создана!"
  end

  # создание поезда
  def create_train
    loop do
      case text_interface(["Грузовой поезд", "Пассажирский поезд"])
      when 0
        print "Введите номер поезда: "
        train = CargoTrain.new(gets.chomp.capitalize)
      when 1
        print "Введите номер поезда: "
        train = PassengerTrain.new(gets.chomp.capitalize)
      end

      if train.valid? == false 
        return
      else
        @trains << train
        puts "Поезд создан!"
        break
      end
    end  
  end

  #создание маршрута
  def create_route
    puts "Выберите первую станцию маршрута:"
    first_station = text_interface(@stations)
    puts "Выберите конечную станцию маршрута:"
    last_station = text_interface(@stations)

    route = Route.new(first_station, last_station)
    @routes << route

    puts "Маршрут #{first_station.name} >>>> #{last_station.name} успешно создан"
  end

  # Управление маршрутами 
  def manage_routes
    
    puts "Выберите маршрут: "
    route = text_interface(@routes)
    
    # Редактируем маршрут
    case text_interface(["Добавить станцию", "Удалить станцию"])
    when 0
      puts "Добавить станцию:"
      station = text_interface(@stations)
      route.add_interm_station(station)
      puts "Станция #{station.name} успешно добавлена в маршрут!"
    when 1
      puts "Удалить станцию:"
      station = text_interface(route.all_stations_on_route)
      route.delete_interm_station(station)
      puts "Станция #{station.name} успешно удалена из маршрута"
    end

  end

  # Управление поездами
  def manage_trains

    puts "Выберите поезд: " 
    train = text_interface(@trains)

    case text_interface(["Определить маршрут", "Добавить вагон", "Удалить вагон", "Вывести список вагонов", "Занять место или объем в вагоне"])
    when 0
      puts "Выберите маршрут: "
      route = text_interface(@routes)
      train.set_train_on_route(route)
      puts "Поезду №#{train.number} определен маршрут"
    when 1
      if train.type == "cargo"
        print "Введите номер вагона: "
        number = gets.chomp
        wagon = CargoWagon.new(number)
        train.add_wagon(number)
        if train.speed == 0
          puts "#{wagon.type} вагон номер #{wagon.number} успешно добавлен к поезду №#{train.number}; объем вагона: #{wagon.volume} m3  "
        else
          puts "Поезд в движении"
        end
      elsif train.type == "passenger"
        print "Введите номер вагона: "
        number = gets.chomp
        wagon = PassangerWagon.new(number)
        train.add_wagon(number)
        if train.speed == 0
          puts "#{wagon.type} вагон номер #{wagon.number} успешно добавлен к поезду №#{train.number}; количество свободных мест: #{wagon.count_places}"
        else
          puts "Поезд в движении"
        end 
      end  
    when 2
      wagon = text_interface(train.wagons)
      train.remove_wagon
      puts "#{wagon.type} вагон успешно отцеплен от поезда №#{train.number}"
    when 3
      if train.type == "cargo"
        block = -> (wagon, i) do
        print "Номер вагона: #{wagon.number} "; 
        print " Тип вагона: #{wagon.type} ";
        puts " Объем вагона: #{wagon.volume} m3  "
        end
      elsif train.type == "passenger"
        block = -> (wagon, i) do
        print "Номер вагона: #{wagon.number} "; 
        print " Тип вагона: #{wagon.type} ";
        puts " Kоличество свободных мест: #{wagon.count_places}"
        end
      end
      train.all_wagons_in_train(block)
    when 4
      puts "Выберите номер вагона для заполения"

      wagon = text_interface(train.wagons)
     
      if train.type == "cargo"
        puts "Введите желаемый объем для заполнения: "
        volume = gets.chomp.to_i
        wagon.occupied_space(volume)
        if wagon.occ_space > wagon.volume
          puts "Недостаточно места для заполнения вагона: перебор#{wagon.free_space} m3"
        else
          puts "Груз успешно помещен в вагон занято: #{wagon.occ_space}, свободно #{wagon.free_space}"
        end
      else train.type == "passenger"
        wagon.occupied_places
        puts "Место успешно занято, количество свободных мест #{wagon.free_places}"
        if wagon.free_places == 0 
          puts "Вагон заполнен, выберите другой вагон"
        end
      end
    end

  # Движение поезда
  def move_train
    puts "Выберите поезд: "
    train = text_interface(@trains)

    puts "Выберите направление движения: "
    case text_interface(["Вперед","Назад"])
    when 0
      train.move_forward
      puts "Поезд продвинулся на одну станцию вперед"
    when 1
      train.move_backward
      puts "Поезд продвинулся на одну станцию назад"
    end
  end

  # Информация о станции
  def station_info
    station = text_interface(@stations)

    system "clear"

    puts "Все поезда на станции #{station.name}:"
   
    block = -> (train) do
      print "Номер поезда: #{train.number} "; 
      print " Тип поезда: #{train.type} ";
      puts " Количество вагонов: #{train.wagons.size}"
    end
    station.all_trains_on_station(block)

    print "Нажмите Enter для выхода."
    gets
    system "clear"
  end
  end
end





