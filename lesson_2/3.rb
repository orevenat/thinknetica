fibo = [1]
c = 1

while c < 100
  fibo << c
  c = fibo[-2] + fibo[-1]
end
puts fibo
