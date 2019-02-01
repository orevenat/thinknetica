require_relative 'valid'

class PassengerCarriage < Carriage
  include Valid

  attr_reader :place_count, :places

  def initialize(size)
    @place_size = size
    validate!
    @places = []
  end

  def name
    'Пассажирский'
  end

  def fill_place
    places << :f if free_places > 0
  end

  def count
    places.size
  end

  def free_places
    place_count - places.size
  end

  private

  attr_writer :places

  def validate!
    raise 'Size must be integer' unless Integer(place_count)
    raise 'Must be large than 0' if place_count < 1
  end
end
