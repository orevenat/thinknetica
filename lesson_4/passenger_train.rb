class PassengerTrain < Train
  protected

  def carriage_type_same?(carriage)
    carriage.class.to_s.to_sym == :PassengerCarriage
  end
end
