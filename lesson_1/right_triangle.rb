sides = []

3.times do
  puts 'Введите сторону'
  sides << gets.chomp.to_f
end

def check_triangle(arr)
  return 'равносторонний' if arr.uniq.size == 1

  cat1, cat2, hyp = arr.sort
  if hyp**2 == cat1**2 + cat2**2
    return 'прямоугольный и равнобедренный' if cat1 == cat2

    return 'прямоугольный'
  end
  'не прямоугольный'
end

puts check_triangle(sides)
