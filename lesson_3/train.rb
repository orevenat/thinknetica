class Train
  attr_accessor :speed
  attr_reader :carriage
  attr_reader :type

  def initialize(number, type, carriage)
    @number = number
    @type = type
    @carriage = carriage
    @speed = 0
  end

  def add_carriage
    @carriage += 1 if @speed.zero?
  end

  def remove_carriage
    @carriage -= 1 if @speed.zero?
  end

  def stop
    @speed = 0
  end

  def add_route(route)
    @route = route
    @current_station = 0
  end

  def next_station
    @current_station += 1 if @route.all_stations.size > @current_station + 1
  end

  def prev_station
    @current_station -= 1
  end

  def print_stations
    stations = @route.all_stations
    puts "prev station: #{stations[@current_station - 1]}" if @current_station > 0
    puts "current station: #{stations[@current_station]}"
    puts "next_station #{stations[@current_station + 1]}" if @current_station + 1 < stations.size
  end
end
