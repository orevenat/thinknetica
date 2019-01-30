require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]

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
end
