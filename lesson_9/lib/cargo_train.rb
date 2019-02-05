class CargoTrain < Train
  attr_reader :type

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
