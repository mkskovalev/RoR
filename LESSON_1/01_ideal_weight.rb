print "Введите ваше имя: "
user_name = gets.chomp

print "Введите ваш рост: "
height = Integer(gets)

ideal_weight = (height - 110) * 1.15

if ideal_weight < 0
  print "#{user_name}, ваш вес уже оптимальный!"
else
  print "#{user_name}, ваш идеальный вес: #{ideal_weight} кг"
end