coeff_name = %w[a b c]
coeff = []

coeff_name.each do |x|
  puts "Введите коэффициент #{x}"
  coeff << gets.chomp.to_f
end

def quadratic_equation(a, b, c)
  d = (b**2) - (4 * a * c)
  message = "D = #{d} "
  if d < 0
    message += 'Корней нет'
  elsif d.zero?
    x = (-b) / 2 * a
    message += "Корень: #{x}"
  else
    d_sqrt = Math.sqrt(d)
    x1 = (-b) + d_sqrt / 2 * a
    x2 = (-b) - d_sqrt / 2 * a
    message += "Корни: #{x1}, #{x2}"
  end
  message
end

puts quadratic_equation(*coeff)
