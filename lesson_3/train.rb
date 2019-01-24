class Train
  attr_reader :speed
  attr_reader :carriages
  attr_reader :type

  def initialize(number, type, carriages)
    @number = number
    @type = type
    @carriages = carriages
    @speed = 0
  end

  def add_carriage
    @carriages += 1 if speed.zero?
  end

  def remove_carriage
    @carriages -= 1 if speed.zero?
  end

  def add_speed(value)
    @speed += value
  end

  def stop
    @speed = 0
  end

  def add_route(route)
    @route = route
    @current_station = 0
    @route.stations[@current_station].add_train(self)
  end

  def to_next_station
    if @route.stations.size > @current_station + 1
      @route.stations[@current_station].send_train(self)
      @current_station += 1
      @route.stations[@current_station].add_train(self)
    end
  end

  def to_prev_station
    if @current_station > 0
      @route.stations[@current_station].send_train(self)
      @current_station -= 1
      @route.stations[@current_station].add_train(self)
    end
  end

  def prev_station
    @route.stations[@current_station - 1] if @current_station > 0
  end

  def current_station
    @route.stations[@current_station]
  end

  def next_station
    stations = @route.stations
    stations[@current_station + 1] if @current_station + 1 < stations.size
  end
end
