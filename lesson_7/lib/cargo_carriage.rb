require_relative 'valid'

class CargoCarriage < Carriage
  include Valid

  attr_reader :volume_size, :volume
  alias size volume_size
  alias filled_size volume

  def initialize(size)
    @volume_size = size
    validate!
    @volume = 0
  end

  def fill
    can_fill? ? self.volume += 1 : (raise 'Volume full')
  end

  def clear
    can_clear? ? self.volume -=  1 : (raise 'Volume is empty')
  end

  def free_volume
    volume_size - volume
  end

  def name
    "Грузовой с объемом #{volume_size}"
  end

  private

  attr_writer :volume

  def can_fill?
    volume_size - volume > 0
  end

  def can_clear?
    volume > 1
  end

  def validate!
    raise 'Size must be integer' unless Integer(volume_size)
    raise 'Must be large than 0' if volume_size < 1
  end
end
