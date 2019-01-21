puts 'Введите основание треугольника'
base = gets.chomp.to_i

puts 'Введите высоту треугольника'
height = gets.chomp.to_i

area = 1.0 / 2 * base * height

puts "Площадь треугольника #{area}"
