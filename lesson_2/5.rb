months_length = { 1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 6 => 30, 7 => 31,
                  8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31 }

puts 'Введите день'
day = gets.chomp.to_i
puts 'Введите номер месяца'
month = gets.chomp.to_i
puts 'Введите год'
year = gets.chomp.to_i

months_length[2] = 29 if (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
result = months_length.values.first(month - 1).sum + day

puts result
