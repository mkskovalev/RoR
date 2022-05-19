product_list = {}
amount = 0

loop do
  puts "Введите название товара"
  product_name = gets.chomp.to_s

  break if product_name == "стоп"  

  puts "Введите цену за единицу"
  product_price = gets.chomp.to_i

  puts "Введите кол-во товара"
  product_quantity = gets.chomp.to_f

  product_list[product_name] = {"price" => product_price, "quantity" => product_quantity}
end

puts "\n#{product_list}\n\n"

product_list.each do |name, price_quantity|
  summ = (price_quantity["price"] * price_quantity["quantity"]).to_f
  puts "#{name} - #{price_quantity["price"]} x #{price_quantity["quantity"]} = #{summ}"
  amount += summ
end

puts "Общая сумма: #{amount}"
