require_relative 'valid'

class PassengerCarriage < Carriage
  include Valid

  attr_reader :place_count, :places_filled
  alias size place_count
  alias filled_size places_filled

  def initialize(size)
    @place_count = size
    validate!
    @places_filled = 0
  end

  def fill
    can_fill? ? self.places_filled += 1 : (raise 'All places is full')
  end

  def clear
    can_clear? ? self.places_filled -= 1 : (raise 'All places is empty')
  end

  def free_places
    place_count - filled_size
  end

  def name
    "Пассажирский с объемом #{place_count}"
  end

  private

  attr_writer :places_filled

  def can_fill?
    free_places > 0
  end

  def can_clear?
    places_filled > 1
  end

  def validate!
    raise 'Size must be integer' unless Integer(place_count)
    raise 'Must be large than 0' if place_count < 1
  end
end
