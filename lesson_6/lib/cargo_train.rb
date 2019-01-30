class CargoTrain < Train
  protected

  def carriage_type_same?(carriage)
    carriage.class == CargoCarriage
  end
end
