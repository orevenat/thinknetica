fibo = [1, 1]
a, b = fibo
loop do
  c = a + b
  break if c > 100

  fibo << c
  a = b
  b = c
end
puts fibo
