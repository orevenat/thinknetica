class Station
  attr_reader :trains
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def trains_count_by_type(type)
    current_type_trains = trains.select do |train|
      train.class == type
    end
    current_type_trains.size
  end

  def add_train(train)
    trains << train
  end

  def send_train(train)
    trains.delete(train)
  end

  private

  attr_writer :trains
end
