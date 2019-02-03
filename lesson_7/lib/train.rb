require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'valid'

class Train
  NUMBER_FORMAT = /^\w{3}-?\w{2}$/.freeze

  include Manufacturer
  include InstanceCounter
  include Valid

  attr_reader :number, :type, :carriages, :speed
  alias name number

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number)
    @number = number
    @carriages = []
    @speed = 0
    @@trains[number] = self
    validate!
    register_instance
  end

  def add_carriage(carriage)
    carriages << carriage if can_join_carriage?(carriage)
  end

  def remove_carriage
    carriages.delete(-1) if can_remove_carriage?
  end

  def carriages_count
    carriages.size
  end

  def each_carriage
    carriages.each { |c| yield(c) }
  end

  def add_speed(value)
    self.speed += value
  end

  def stop
    self.speed = 0
  end

  def add_route(route)
    self.route = route
    self.current_station = 0
    self.route.stations[current_station].add_train(self)
  end

  def to_next_station
    move_to_next_station if route.stations.size > current_station + 1
  end

  def to_prev_station
    move_to_prev_station if current_station > 0
  end

  def show_next_station
    stations = route.stations
    stations[current_station + 1] if current_station + 1 < stations.size
  end

  def show_prev_station
    route.stations[current_station - 1] if current_station > 0
  end

  def show_current_station
    route.stations[current_station]
  end

  protected

  attr_accessor :route, :current_station
  attr_writer :speed, :carriages

  def validate!
    raise "Number can't be nil" if number.nil?
    raise 'Number should be at least 6 symbols' if number.length < 5
    raise 'Number has invalid format' if number !~ NUMBER_FORMAT
  end

  def can_join_carriage?(carriage)
    speed.zero? && carriage_type_same?(carriage)
  end

  def can_remove_carriage?
    speed.zero? && !carriages.empty?
  end

  def carriage_type_same?(carriage)
    carriage.class == Carriage
  end

  def move_to_next_station
    route.stations[current_station].send_train(self)
    self.current_station += 1
    route.stations[current_station].add_train(self)
  end

  def move_to_prev_station
    route.stations[current_station].send_train(self)
    self.current_station -= 1
    route.stations[current_station].add_train(self)
  end
end
