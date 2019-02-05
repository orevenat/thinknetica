class PassengerTrain < Train
  attr_reader :type

  def initialize(number)
    super(number)
    @type = :Passenger
  end

  protected

  attr_writer :type

  def carriage_type_same?(carriage)
    carriage.class == PassengerCarriage
  end
end
