require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'carriage'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'

st1 = Station.new('Moscow')
st2 = Station.new('Spb')
st3 = Station.new('NN')
st4 = Station.new('Kazan')
st5 = Station.new('Vladimir')
st6 = Station.new('Volgograd')
st7 = Station.new('Vologda')

rt1 = Route.new(st1, st2)
rt1.add_station(st3)
rt1.add_station(st4)
rt1.add_station(st5)
puts rt1.name
