print 'Введите первую сторону треугольника: '
side_1 = Integer(gets)

print 'Введите вторую сторону треугольника: '
side_2 = Integer(gets)

print 'Введите третью сторону треугольника: '
side_3 = Integer(gets)

sorted_sides = [side_1, side_2, side_3].sort

pythagoras = (sorted_sides[2]**2) - ((sorted_sides[0]**2) + (sorted_sides[1]**2))

if pythagoras == 0
  puts 'Треугольник прямоугольный'
elsif sorted_sides[0] - sorted_sides[1] == 0 && sorted_sides[0] != sorted_sides[2]
  puts 'Треугольник равнобедренный'
elsif sorted_sides[0] == sorted_sides[1] && sorted_sides[0] == sorted_sides[2]
  puts 'Треугольник равносторонний'
else
  puts 'Треугольник не является прямоугольным, равнобедренным или равносторонним'
end
