class Railroad
  def initialize
    @trains = []
    @routes = []
    @stations = []
  end

  def run
    main_menu
  end

  private

  attr_accessor :trains, :routes, :stations

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
    puts menu_content([['Для создания и управления странцими', '1'],
                       ['Для создания и управления поездами', '2'],
                       ['Для создания и изменения маршрута', '3'],
                       ['Для завершения программы', '4']])

    answer = gets.chomp
    case answer
    when '1'
      stations_menu
    when '2'
      trains_menu
    when '3'
      routes_menu
    when '4'
      exit
    else
      main_menu
    end
  end

  def stations_menu
    puts menu_header('Меню станций')
    puts menu_content([['Добавить новую станцию', '1'],
                       ['Показать список станций', '2'],
                       ['Для возврата в главное меню', '3']])

    answer = gets.chomp
    case answer
    when '1'
      new_station_menu
    when '2'
      show_stations_menu
      stations_menu
    when '3'
      main_menu
    else
      stations_menu
    end
  end

  def show_stations_menu
    stations.each do |station|
      puts "#{station.name} #{station.trains.map(&:name).join(' ')}"
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
    puts menu_content([['Для добавления нового маршрута', '1'],
                       ['Для изменения существующего маршрута', '2'],
                       ['Для возврата в главное меню', '3']])

    answer = gets.chomp
    case answer
    when '1'
      new_route_menu
    when '2'
      change_route_menu
    when '3'
      main_menu
    else
      routes_menu
    end
  end

  def new_route_menu
    puts menu_header('Добавление нового маршрута')
    puts 'Список станций:'
    puts menu_content(list_of_items(stations))
    puts 'Введите цифру первой станции'
    st1 = gets.to_i
    puts 'Введите цифру второй станции'
    st2 = gets.to_i
    new_route = Route.new(stations[st1], stations[st2])
    routes << new_route
    control_route_menu(new_route)
  end

  def change_route_menu
    puts menu_header('Изменение маршрута')
    puts 'Список маршрутов:'
    puts menu_content(list_of_items(routes))
    puts 'Введите цифру маршрута или b для перехода назад'
    rt = gets.chomp
    routes_menu if rt == 'b'
    control_route_menu(routes[rt.to_i]) if routes[rt.to_i]
    change_route_menu
  end

  def control_route_menu(route)
    puts menu_header('Меню маршрутов')
    puts menu_content([['Для добавления новой станции', '1'],
                       ['Для удаления существующей станции', '2'],
                       ['Для возврата в меню маршрутов', '3']])

    answer = gets.chomp
    case answer
    when '1'
      new_station(route)
    when '2'
      remove_station(route)
    when '3'
      routes_menu
    else
      control_route_menu(route)
    end
  end

  def new_station(route)
    puts menu_header('Добавление новой станции')
    puts 'Список станций:'
    puts menu_content(list_of_items(stations))
    puts 'Введите цифру первой станции или b для возврата'
    st = gets.chomp
    control_route_menu(route) if st == 'b'
    route.add_station(stations[st.to_i]) if stations[st.to_i]
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
    puts menu_content([['Для добавления нового поезда', '1'],
                       ['Для изменения существующего поезда', '2'],
                       ['Для возврата в главное меню', '3']])

    answer = gets.chomp
    case answer
    when '1'
      new_trains_menu
    when '2'
      change_train_menu
    when '3'
      main_menu
    else
      trains_menu
    end
  end

  def new_trains_menu
    puts menu_header('Добавление нового поезда')
    puts 'Введите имя'
    name = gets.chomp
    puts menu_content([['Пассажирский поезд', '1'],
                       ['Грузовой поезд', '2']])

    answer = gets.chomp
    case answer
    when '1'
      new_train = PassengerTrain.new(name)
    when '2'
      new_train = CargoTrain.new(name)
    else
      new_trains_menu
    end
    trains << new_train
    control_train_menu(new_train)
  end

  def change_train_menu
    puts menu_header('Изменение поезда')
    puts 'Список поездов:'
    puts menu_content(list_of_items(trains))
    puts 'Введите цифру поезда или b для перехода назад'
    tr = gets.chomp
    trains_menu if tr == 'b'
    control_train_menu(trains[tr.to_i]) if trains[tr.to_i]
    change_train_menu
  end

  def control_train_menu(train)
    puts menu_header('Меню маршрутов')
    puts menu_content([['Для назначения маршрута поезду', '1'],
                       ['Для добавления вагона', '2'],
                       ['Для отцепления вагона', '3'],
                       ['Переместить поезд по маршруту вперед', '4'],
                       ['Переместить поезд по маршруту назад', '5'],
                       ['Для возврата в меню поездов', '6'],
                       ['Список всех станций и поездов', '7'],
                       ['Выйти в главное меню', '8']])

    answer = gets.chomp
    case answer
    when '1'
      route_to_train(train)
    when '2'
      add_carriage_to_train(train)
    when '3'
      remove_carriage(train)
    when '4'
      next_station(train)
    when '5'
      prev_station(train)
    when '6'
      trains_menu
    when '7'
      show_stations_menu
      control_train_menu(train)
    when '8'
      main_menu
    else
      control_train_menu(train)
    end
    control_train_menu(train)
  end

  def route_to_train(train)
    puts menu_header('Добавление маршрута поезда')
    puts 'Список маршрутов:'
    puts menu_content(list_of_items(routes))
    puts 'Введите цифру первой станции или b для возврата'
    rt = gets.chomp
    control_train_menu(train) if rt == 'b'
    train.add_route(routes[rt.to_i]) && control_train_menu(train) if routes[rt.to_i]
    route_to_train(train)
  end

  def add_carriage_to_train(train)
    puts 'вагон добавлен'
    train_type = train.class
    if train_type == PassengerTrain
      train.add_carriage(PassengerCarriage.new)
    elsif train_type == CargoTrain
      train.add_carriage(CargoCarriage.new)
    end
  end

  def remove_carriage(train)
    if train.carriages_count > 0
      train.remove_carriage
      puts 'Вагон удален'
    else
      puts 'Нет вагонов для удаления'
    end
  end

  def next_station(train)
    train.to_next_station
    puts train.show_current_station.name
  end

  def prev_station(train)
    train.to_prev_station
    puts train.show_current_station.name
  end
end
