require_relative 'instance_counter'
require_relative 'valid'

class Station
  include InstanceCounter
  include Valid

  @@stations = []

  def self.all
    @@stations
  end

  attr_reader :trains
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def trains_count_by_type(type)
    current_type_trains = trains.select do |train|
      train.class == type
    end
    current_type_trains.size
  end

  def add_train(train)
    trains << train
  end

  def send_train(train)
    trains.delete(train)
  end

  private

  def validate!
    raise "Name can't be empty" if name.nil?
    raise 'Name should be at least 3 symbols' if name.length < 3
  end

  attr_writer :trains
end
