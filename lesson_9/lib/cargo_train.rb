require_relative 'validation'

class CargoTrain < Train
  NUMBER_FORMAT = /^\w{3}-?\w{2}$/.freeze

  include Validation

  attr_reader :type

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def initialize(number)
    super(number)
    @type = :Cargo
  end

  protected

  attr_writer :type

  def carriage_type_same?(carriage)
    carriage.class == CargoCarriage
  end
end
