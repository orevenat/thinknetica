class CargoTrain < Train
  protected

  def carriage_type_same?(carriage)
    carriage.class.to_s.to_sym = :CargoCarriage
  end
end
