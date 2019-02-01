require_relative 'valid'

class CargoCarriage < Carriage
  include Valid

  attr_reader :volume_size, :volume

  def initialize(size)
    @volume_size = size
    validate!
    @volume = []
  end

  def name
    'Грузовой'
  end

  def fill_volume
    volume << :f if free_volume > 0
  end

  def count
    volume.size
  end

  def free_volume
    volume_count - volume.size
  end

  private

  attr_writer :volume

  def validate!
    raise 'Size must be integer' unless Integer(volume_size)
    raise 'Must be large than 0' if volume_size < 1
  end
end
