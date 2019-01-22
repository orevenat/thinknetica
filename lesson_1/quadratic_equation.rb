include Math
coeffName = ["a", "b", "c"]
coeff = []

coeffName.each do |x|
  puts "Введите коэффициент #{x}"
  coeff << gets.chomp.to_i
end

def quadratic_equation(a, b, c)
  d = (b**2) - (4*a*c)
  message = "D = #{d} "
  if (d < 0)
    message += "Корней нет"
  elsif (d == 0)
    x = (-b) / 2*a
    message += "Корень: #{x}"
  else
    x1 = (-b) + Math.sqrt(d) / 2*a
    x2 = (-b) - Math.sqrt(d) / 2*a
    message += "Корни: #{x1}, #{x2}"
  end
  message
end

puts quadratic_equation *coeff
