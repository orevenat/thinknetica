class PassengerTrain < Train
  protected

  def carriage_type_same?(carriage)
    carriage.class == PassengerCarriage
  end
end
