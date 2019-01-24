require_relative 'route'
require_relative 'station'
require_relative 'train'

train1 = Train.new('123', :passanger, 5)
train2 = Train.new('124', :cargo, 8)
train3 = Train.new('125', :cargo, 4)
train4 = Train.new('126', :passanger, 3)

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
puts route1.all_stations

train1.add_route(route1)
train2.add_route(route1)
train3.add_route(route1)

train1.speed = 50
train1.next_station
train1.next_station
train1.print_stations

station2.add_train(train2)
station2.add_train(train1)
station2.add_train(train3)
station2.send_train(train2)
station2.add_train(train4)
station2.trains_by_type
