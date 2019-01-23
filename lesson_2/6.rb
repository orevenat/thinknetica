basket = {}

loop do
  puts 'Введите наименование товара'
  name = gets.chomp
  break if name == 'стоп'

  puts 'Введите цену товара'
  price = gets.chomp.to_f
  puts 'Введите количество товара'
  quantity = gets.chomp.to_i
  basket[name.to_sym] = { price: price, quantity: quantity, sum: price * quantity }
end

sum = 0

basket.each do |name, item|
  sum += item[:sum]
  puts "#{name} цена: #{item[:price]}, количество: #{item[:quantity]}, сумма: #{item[:sum]}"
end

puts "Итого: #{sum}"
