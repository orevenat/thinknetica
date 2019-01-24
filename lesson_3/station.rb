class Station
  TYPE = [:passanger, :cargo]

  attr_reader :trains

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

  def trains_by_type
    TYPE.each do |type|
      current_type_trains = trains.select { |train| train.type == type }
      count = current_type_trains.size
      puts "#{type}: #{count}"
    end
  end
end
