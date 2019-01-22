sides = []

3.times do
  puts 'Введите сторону'
  sides << gets.chomp.to_i
end

def check_triangle(arr)
  cat1, cat2, hyp = arr.sort
  if hyp ** 2 == cat1 ** 2 + cat2 ** 2
    if cat1 == cat2
      puts 'прямоугольный и равнобедренный'
    else
      puts 'прямоугольный'
    end
    puts 'не прямоугольный'
  end
end

puts check_triangle(sides)
