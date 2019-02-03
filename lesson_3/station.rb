class Station
  TYPE = %i[passanger cargo].freeze

  attr_reader :trains
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def trains_count_by_type(type)
    current_type_trains = trains.select { |train| train.type == type }
    current_type_trains.size
  end
end
