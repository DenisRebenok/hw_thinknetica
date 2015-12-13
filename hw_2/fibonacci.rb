fib = [0,1]

while (x = fib[-1] + fib[-2]) < 100 do
  fib << x
end

p fib