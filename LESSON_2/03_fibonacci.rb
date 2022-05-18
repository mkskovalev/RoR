array = []
count = 0
fibo = 0
golden_ratio = 1.618034

while fibo < 100
  fibo = Integer((golden_ratio**count - (1 - golden_ratio)**count) / Math.sqrt(5))
  count += 1
  array.push(fibo) if fibo < 100
end
