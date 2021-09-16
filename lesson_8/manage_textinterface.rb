# frozen_string_literal: true

module ManageTextInterface
  MAIN_MENU_ITEMS = [
    { title: 'Создать станцию', action: :create_station },
    { title: 'Создать поезд', action: :create_train },
    { title: 'Создать маршрут', action: :create_route },
    { title: 'Управление маршрутами', action: :manage_routes },
    { title: 'Управление поездами', action: :manage_trains },
    { title: 'Движение поезда', action: :move_train },
    { title: 'Информация о станциях', action: :station_info }
  ].freeze

  def text_interface(items)
    puts ''

    # detect type of input array
    items = items.collect { |item| item[:title] } if items[0].is_a? Hash

    # select item from list
    choice = select_item(items)

    # return result
    items[choice].instance_of?(String) ? choice : items[choice]
  end

  def format_item(item)
    choice = item.number if item.is_a? Train
    choice = "Вагон №. #{i}" if item.is_a? Wagon
    choice = item.name if item.is_a? Station
    choice = "#{item.routes.first.name} >>>> #{item.routes.last.name}" if item.is_a? Route
    choice = item if item.is_a? String

    choice
  end

  def print_items(items)
    items.each_with_index do |item, i|
      item_string = format_item(item)
      puts "#{i + 1}. #{item_string}"
    end
  end

  def select_item(items)
    choice = 0
    loop do
      # print menu items
      print_items(items)

      # ask to select item
      print "\nВведите значение: "
      choice = gets.chomp.to_i - 1
      system 'clear'

      break unless choice.negative? || choice >= items.size

      puts 'Please select an existing item!'
    end
    choice
  end

  def run_action(actions, *args)
    index = text_interface(actions)
    action = actions[index][:action]
    send(action, *args)
  end
end
