require_relative 'route'
require_relative 'station'
require_relative 'train'

train1 = Train.new('123', :passanger, 5)
train2 = Train.new('124', :cargo, 8)
train3 = Train.new('125', :cargo, 4)

station1 = Station.new('Moscow')
station2 = Station.new('Spb')
station3 = Station.new('Kazan')
station4 = Station.new('NN')
station5 = Station.new('Omsk')
station6 = Station.new('Novosibirks')
station7 = Station.new('Vladivostok')

route1 = Route.new(station1, station7)
route1.add_station(station2)
route1.add_station(station3)
route1.add_station(station4)
route1.add_station(station5)
route1.add_station(station6)
route1.remove_station(station4)

train1.add_route(route1)
train2.add_route(route1)
train3.add_route(route1)

train1.add_speed(50)
train1.to_next_station
train1.to_next_station
puts train1.current_station
