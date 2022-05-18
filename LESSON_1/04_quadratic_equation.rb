print "Введите первое число: "
a = Integer(gets)

print "Введите второе число: "
b = Integer(gets)

print "Введите третье число: "
c = Integer(gets)

discriminant = (b ** 2) - 4 * a * c

if discriminant > 0
  x1 = (-b + Math.sqrt(discriminant)) / (2 * a)
  x2 = (-b - Math.sqrt(discriminant)) / (2 * a)
	puts "Дискрименант: #{discriminant}, x1: #{x1}, x2: #{x2}"
elsif discriminant == 0
  x1 = (-b + Math.sqrt(discriminant)) / (2 * a)
  puts "Дискрименант: #{discriminant}, корень: #{x1}"
elsif discriminant < 0
  puts "Дискрименант: #{discriminant}, корней нет."
end