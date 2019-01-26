require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'carriage'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'

@trains = []
@routes = []
@stations = []

def menu_header(text)
  %(
--------------------------------------------------------------------
                         #{text}
--------------------------------------------------------------------
)
end

def menu_content(lines)
  new_lines = lines.map { |text, button| "- #{text} нажмите '#{button}'" }
  new_lines.join("\n")
end

def list_of_items(list)
  list.each_with_index.map do |item, index|
    [item.name, index]
  end
end

def main_menu
  puts menu_header('Программа для поездов')
  puts menu_content([['Для создания и управления странцими', 's'],
                     ['Для создания и управления поездами', 't'],
                     ['Для создания и изменения маршрута', 'r'],
                     ['Для завершения программы', 'x']])

  answer = gets.chomp
  case answer
  when 's'
    stations_menu
  when 't'
    trains_menu
  when 'r'
    routes_menu
  when 'x'
    exit
  else
    main_menu
  end
end

def stations_menu
  puts menu_header('Меню станций')
  puts menu_content([['Добавить новую станцию', 'n'],
                     ['Показать список станций', 'l'],
                     ['Для возврата в главное меню', 'b']])

  answer = gets.chomp
  case answer
  when 'n'
    new_station_menu
  when 'l'
    show_stations_menu
    stations_menu
  when 'b'
    main_menu
  else
    stations_menu
  end
end

def show_stations_menu
  @stations.each do |station|
    puts "#{station.name} #{station.trains.map(&:number).join(' ')}"
  end
end

def new_station_menu
  puts menu_header('Добавление новой станции')
  puts 'Введите имя'
  name = gets.chomp
  @stations << Station.new(name)
  puts 'Станция добавлена'
  stations_menu
end

def routes_menu
  puts menu_header('Меню маршрутов')
  puts menu_content([['Для добавления нового маршрута', 'n'],
                     ['Для изменения существующего маршрута', 'c'],
                     ['Для возврата в главное меню', 'b']])

  answer = gets.chomp
  case answer
  when 'n'
    new_route_menu
  when 'c'
    change_route_menu
  when 'b'
    main_menu
  else
    routes_menu
  end
end

def new_route_menu
  puts menu_header('Добавление нового маршрута')
  puts 'Список станций:'
  puts menu_content(list_of_items(@stations))
  puts 'Введите цифру первой станции'
  st1 = gets.to_i
  puts 'Введите цифру второй станции'
  st2 = gets.to_i
  new_route = Route.new(@stations[st1], @stations[st2])
  @routes <<  new_route
  control_route_menu(new_route)
end

def change_route_menu
  puts menu_header('Изменение маршрута')
  puts 'Список маршрутов:'
  puts menu_content(list_of_items(@routes))
  puts 'Введите цифру маршрута или b для перехода назад'
  rt = gets.chomp
  routes_menu if rt == 'b'
  control_route_menu(@routes[rt.to_i]) if @routes[rt.to_i]
  change_route_menu
end

def control_route_menu(route)
  puts menu_header('Меню маршрутов')
  puts menu_content([['Для добавления новой станции', 'n'],
                     ['Для удаления существующей станции', 'd'],
                     ['Для возврата в меню маршрутов', 'b']])

  answer = gets.chomp
  case answer
  when 'n'
    new_station(route)
  when 'd'
    remove_station(route)
  when 'b'
    routes_menu
  else
    control_route_menu(route)
  end
end

def new_station(route)
  puts menu_header('Добавление новой станции')
  puts 'Список станций:'
  puts menu_content(list_of_items(@stations))
  puts 'Введите цифру первой станции или b для возврата'
  st = gets.chomp
  control_route_menu(route) if st == 'b'
  route.add_station(@stations[st.to_i]) if @stations[st.to_i]
  new_station(route)
end

def remove_station(route)
  puts menu_header('Удаление станции')
  puts 'Список станций:'
  puts menu_content(list_of_items(route.stations))
  puts 'Введите цифру первой станции или b для возврата'
  st = gets.chomp
  control_route_menu(route) if st == 'b'
  route.remove_station(route.stations[st.to_i]) if route.stations[st.to_i]
  remove_station(route)
end

def trains_menu
  puts menu_header('Меню поездов')
  puts menu_content([['Для добавления нового поезда', 'n'],
                     ['Для изменения существующего поезда', 'c'],
                     ['Для возврата в главное меню', 'b']])

  answer = gets.chomp
  case answer
  when 'n'
    new_trains_menu
  when 'c'
    change_train_menu
  when 'b'
    main_menu
  else
    trains_menu
  end
end

def new_trains_menu
  puts menu_header('Добавление нового поезда')
  puts 'Введите имя'
  name = gets.chomp
  puts menu_content([['Пассажирский поезд', 'p'],
                     ['Грузовой поезд', 'c']])

  answer = gets.chomp
  case answer
  when 'p'
    new_train = PassengerTrain.new(name)
  when 'c'
    new_train = CargoTrain.new(name)
  else
    new_trains_menu
  end
  @trains <<  new_train
  control_train_menu(new_train)
end

def change_train_menu
  puts menu_header('Изменение поезда')
  puts 'Список поездов:'
  puts menu_content(list_of_items(@trains))
  puts 'Введите цифру поезда или b для перехода назад'
  tr = gets.chomp
  trains_menu if tr == 'b'
  control_train_menu(@trains[tr.to_i]) if @trains[tr.to_i]
  change_train_menu
end

def control_train_menu(train)
  puts menu_header('Меню маршрутов')
  puts menu_content([['Для назначения маршрута поезду', 'r'],
                     ['Для добавления вагона', 'c'],
                     ['Для отцепления вагона', 'd'],
                     ['Переместить поезд по маршруту вперед', 'n'],
                     ['Переместить поезд по маршруту назад', 'p'],
                     ['Для возврата в меню поездов', 'b']])

  answer = gets.chomp
  case answer
  when 'r'
    route_to_train(train)
  when 'c'
    add_carriage_to_train(train)
  when 'd'
    train.remove_carriage
  when 'n'
    train.to_next_station
  when 'p'
    train.to_prev_station
  when 'b'
    trains_menu
  else
    control_train_menu(train)
  end
  control_train_menu(train)
end

def route_to_train(train)
  puts menu_header('Добавление маршрута поезда')
  puts 'Список маршрутов:'
  puts menu_content(list_of_items(@routes))
  puts 'Введите цифру первой станции или b для возврата'
  rt = gets.chomp
  control_route_menu(train) if rt == 'b'
  train.add_station(@routes[rt.to_i]) if @routes[rt.to_i]
  route_to_train(train)
end

def add_carriage_to_train(train)
  train_type = train.class.to_s.to_sym
  if train_type == :PassengerTrain
    train.add_carriage(PassengerCarriage.new)
  elsif train_type == :passenger_train
    train.add_carriage(CargoCarriage.new)
  end
end

main_menu
