class Railroad
  MAIN_TITLE = 'Программа для управления железной дорогой'.freeze
  SET_STATION_NAME = 'Введите имя станции'.freeze
  STATION_ADDED = 'Добавлена станция: '.freeze
  STATION_REMOVED = 'Удалена станция: '.freeze
  STATIONS_LIST = 'Список станций:'.freeze
  STATION_NAME = 'Станция: '.freeze
  SET_STATION_1 = 'Введите цифру первой станции'.freeze
  SET_STATION_2 = 'Введите цифру второй станции'.freeze
  ROUTE_ADDED = 'Маршрут построен: '.freeze
  ROUTE_CONNECTED = 'Маршрут прикреплен: '.freeze
  ROUTE_LIST = 'Список маршрутов:'.freeze
  TRAIN_LIST = 'Список поездов:'.freeze
  TRAIN_ADDED = 'Поезд добавлен: '.freeze
  TRAIN_ADD_TITLE = 'Введите номер поезда в формате ххх-хх'.freeze
  CARRIAGE_ADDED = ' вагон добавлен'.freeze
  CARRIAGE_REMOVED = 'Вагон удален'.freeze
  NO_CARRIAGE = 'Нет вагонов для удаления'.freeze
  CARRIAGE_LIST = 'Список вагонов:'.freeze
  CARRIAGE_ADDED_RESULT = 'Вагон добавлен '.freeze
  CARRIAGE_ADD_TITLE = 'Выберите тип вагона'.freeze
  CARRIAGE_ADD_COUNT = 'Введите количество мест'.freeze
  CARRIAGE_ADD_VOLUME = 'Введите объем'.freeze
  CARRIAGE_FILLED = 'Место/объем занято. Всего: '.freeze
  CARRIAGE_CLEARED = 'Место/объем очищено. Всего:'.freeze

  ACTION_LIST = [
    ['Создать станцию', :add_new_station],
    ['Создать поезд', :add_new_train],
    ['Создать маршрут', :add_new_route],
    ['Назначаить маршрут поезду', :route_to_train],
    ['Добавить станцию в маршрут', :route_new_station],
    ['Удалить станцию из маршрута', :route_remove_station],
    ['Создать вагон', :create_new_carriage],
    ['Заполнить вагон', :fill_carriage],
    ['Освободить вагон', :clear_carriage],
    ['Показать список вагонов у поезда', :show_train_carriages],
    ['Прицепить вагон к поезду', :add_carriage_to_train],
    ['Отцепить вагона от поезда', :remove_carriage],
    ['Переместить поезд по маршруту вперед', :next_station],
    ['Переместить поезд по маршруту назад', :prev_station],
    ['Вывести список станций', :show_stations_list],
    ['Показать список поездов на станции', :show_station_trains],
    ['Выйти из программы', :exit]
  ].freeze

  def initialize
    @trains = []
    @routes = []
    @stations = []
    @carriages = []
  end

  def run
    puts menu_header(MAIN_TITLE)
    main_menu
  end

  private

  attr_accessor :trains, :routes, :stations, :carriages

  def menu_header(text)
    %(
--------------------------------------------------------------------
            #{text}
--------------------------------------------------------------------
 )
  end

  def menu_lines(lines)
    lines.each { |text, button| puts "#{button}. #{text}" }
  end

  def menu(menu_items)
    menu_options = menu_items.each.with_index(1).map do |item, i|
      [item[0], i]
    end
    method_list = ('1'..menu_items.size.to_s).zip(menu_items).to_h

    loop do
      menu_lines(menu_options)
      answer = gets.chomp
      method(method_list[answer][1]).call
      break if answer == menu_items.size.to_s
    end
  end

  def main_menu
    menu(ACTION_LIST)
  end

  def add_new_station
    puts SET_STATION_NAME
    name = gets.chomp
    @stations << Station.new(name)
    puts "#{STATION_ADDED}#{name}"
    sleep 1
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def add_new_route
    puts STATIONS_LIST
    menu_lines(list_of_items(stations))
    puts SET_STATION_1
    st1 = gets.to_i
    puts SET_STATION_2
    st2 = gets.to_i
    new_route = Route.new(stations[st1], stations[st2])
    routes << new_route
    puts "#{ROUTE_ADDED}#{new_route.name}"
    sleep 1
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def add_new_train
    puts TRAIN_ADD_TITLE
    number = gets.chomp
    menu_lines([['Пассажирский поезд', '1'], ['Грузовой поезд', '2']])

    answer = gets.chomp
    case answer
    when '1'
      new_train = PassengerTrain.new(number)
    when '2'
      new_train = CargoTrain.new(number)
    else
      add_new_train
    end
    trains << new_train
    puts "#{TRAIN_ADDED}#{new_train.name}"
    sleep 1
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def route_to_train
    route = find_in_collection(routes, ROUTE_LIST)
    train = find_in_collection(trains, TRAIN_LIST)
    train.add_route(route)
    puts "#{ROUTE_CONNECTED}#{route.name}"
    sleep 1
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def route_new_station
    route = find_in_collection(routes, ROUTE_LIST)
    station = find_in_collection(stations, STATIONS_LIST)
    route.add_station(station)
    puts "#{STATION_ADDED}#{station.name}"
    sleep 1
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def route_remove_station
    route = find_in_collection(routes, ROUTE_LIST)
    station = find_in_collection(route.stations, STATIONS_LIST)
    route.remove_station(station)
    puts "#{STATION_REMOVED}#{station.name}"
    sleep 1
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def create_new_carriage
    puts CARRIAGE_ADD_TITLE
    menu_lines([['Пассажирский вагон', '1'], ['Грузовой вагон', '2']])
    answer = gets.chomp
    case answer
    when '1'
      puts CARRIAGE_ADD_COUNT
    when '2'
      puts CARRIAGE_ADD_VOLUME
    else
      create_new_carriage
    end
    size = gets.to_i
    case answer
    when '1'
      new_carriage = PassengerCarriage.new(size)
    when '2'
      new_carriage = CargoCarriage.new(size)
    else
      create_new_carriage
    end
    puts "#{CARRIAGE_ADDED_RESULT}#{new_carriage.name}"
    carriages << new_carriage
    sleep 1
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def fill_carriage
    carriage = find_in_collection(carriages, CARRIAGE_LIST)
    carriage.fill
    puts "#{CARRIAGE_FILLED}#{carriage.filled_size}/#{carriage.size}"
    sleep 1
  rescue RuntimeError => e
    puts e.message
    main_menu
  end

  def clear_carriage
    carriage = find_in_collection(carriages, CARRIAGE_LIST)
    carriage.clear
    puts "#{CARRIAGE_CLEARED}#{carriage.filled_size}/#{carriage.size}"
    sleep 1
  rescue RuntimeError => e
    puts e.message
    main_menu
  end

  def add_carriage_to_train
    train = find_in_collection(trains, TRAIN_LIST)
    carriages_list = carriages.select do |x|
      if train.class == PassengerTrain && x.class == PassengerCarriage
        true
      elsif train.class == CargoTrain && x.class == CargoCarriage
        true
      end
    end
    carriage = find_in_collection(carriages_list, CARRIAGE_LIST)
    train.add_carriage(carriage)
    puts "#{carriage.name}#{CARRIAGE_ADDED}"
    sleep 1
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def show_train_carriages
    train = find_in_collection(trains, TRAIN_LIST)
    train.each_carriage do |c|
      puts c.name
    end
  end

  def remove_carriage
    train = find_in_collection(trains, TRAIN_LIST)
    if train.carriages_count > 0
      train.remove_carriage
      puts CARRIAGE_REMOVED
    else
      puts NO_CARRIAGE
    end
    sleep 1
  end

  def next_station
    train = find_in_collection(trains, TRAIN_LIST)
    train.to_next_station
    puts train.show_current_station.name
    sleep 1
  end

  def prev_station
    train = find_in_collection(trains, TRAIN_LIST)
    train.to_prev_station
    puts train.show_current_station.name
    sleep 1
  end

  def show_stations_list
    puts STATIONS_LIST
    stations.each do |station|
      puts "#{STATION_NAME}#{station.name}"
    end
    sleep 1
  end

  def show_station_trains
    station = find_in_collection(stations, STATIONS_LIST)
    station.each_train do |t|
      puts t.name
    end
    sleep 1
  end

  def find_in_collection(list, title)
    puts title
    menu_lines(list_of_items(list))
    answer = gets.to_i
    item = list[answer]
    item.nil? ? find_in_collection(list, title) : item
  end

  def list_of_items(list)
    list.each_with_index.map do |item, index|
      [item.name, index]
    end
  end
end
