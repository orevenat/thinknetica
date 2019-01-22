months_length = { 1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 6 => 30, 7 => 31,
                  8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31 }

puts 'Введите день'
day = gets.chomp.to_i
puts 'Введите номер месяца'
month = gets.chomp.to_i
puts 'Введите год'
year = gets.chomp.to_i

result = 0
months_length[2] = 29 if (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
i = 1
count = month - 1
count.times do
  result += months_length[i]
  i += 1
end
result += day

puts result
