require_relative 'instance_counter'
require_relative 'valid'
require_relative 'accessors'

class Route
  include InstanceCounter
  include Valid
  extend Accessors

  attr_reader :stations
  attr_accessor_with_history :test
  strong_attr_accessor :test2, Station

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    validate!
    register_instance
  end

  def name
    stations.map(&:name).join('-')
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def remove_station(station)
    stations.delete(station)
  end

  private

  attr_writer :stations

  def validate!
    raise 'Need 2 station at least' if stations.count < 2
    raise 'Station instances needed' if stations.any? do |station|
      station.class != Station
    end
  end
end
