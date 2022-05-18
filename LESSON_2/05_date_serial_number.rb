days_in_months = {
  1 => 31,
  2 => 28,
  3 => 31,
  4 => 30,
  5 => 31,
  6 => 30,
  7 => 31,
  8 => 31,
  9 => 30,
  10 => 31,
  11 => 30,
  12 => 31
}

serial = 0

puts "Введите день:"
day = gets.chomp.to_i

puts "Введите месяц:"
month = gets.chomp.to_i
month = month - 1

puts "Введите год:"
year = gets.chomp.to_i

def count_serial(month, serial, days_in_months, day)
  while month > 0    
    serial = serial + days_in_months[month]
    month -= 1
  end
  serial = serial + day
  return serial
end


if year % 400 == 0 || year % 4 == 0 && year % 100 != 0
  days_in_months[2] = 29
  serial = count_serial(month, serial, days_in_months, day)
else
  serial = count_serial(month, serial, days_in_months, day)
end
