require_relative 'instance_counter'
require_relative 'validation'

class Station
  include InstanceCounter
  include Validation

  @@stations = []

  def self.all
    @@stations
  end

  attr_reader :trains
  attr_reader :name

  validate :name, :presence
  validate :name, :length, 3

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

  def each_train
    trains.each { |t| yield(t) }
  end

  private

  attr_writer :trains
end
