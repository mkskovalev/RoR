array = []
count = 0
fibo = 0
golden_ratio = 1.618034
sqrt = Math.sqrt(5)

loop do
  fibo = (golden_ratio**count - (1 - golden_ratio)**count) / sqrt
  count += 1
  break if fibo > 100

  array.push(fibo.to_i)
end

print array
