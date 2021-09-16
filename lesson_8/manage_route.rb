# frozen_string_literal: true

module ManageRoute
  def manage_route
    puts 'Выберите маршрут: '
    route = text_interface(@routes)
    case text_interface(['Добавить станцию', 'Удалить станцию'])
    when 0
      station = text_interface(@stations)
      route.add_interm_station(station)
    when 1
      station = text_interface(route.all_stations_on_route)
      route.delete_interm_station(station)
    end
  end
end
