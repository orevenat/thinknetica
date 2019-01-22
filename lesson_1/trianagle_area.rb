puts 'Введите основание треугольника'
base = gets.chomp.to_f

puts 'Введите высоту треугольника'
height = gets.chomp.to_f

area = 1.0 / 2 * base * height

puts "Площадь треугольника #{area}"
