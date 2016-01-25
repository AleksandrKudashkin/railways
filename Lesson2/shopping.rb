basket = Hash.new 

loop do
  puts "Введите название товара (стоп - закончить):"
  good = gets.chomp.to_s
  break if good == "стоп"

  puts "Введите стоимость единицы товара:"
  price = gets.chomp.to_f

  puts "Введите количество товара:"
  count = gets.chomp.to_i

  basket[good] = {price: price, count: count}
end

puts "Вы выбрали:"
puts
sum = 0
basket.each do |key, value|
  puts "Товар: " + key
  puts "Цена: " + value[:price].to_s
  puts "Количество: " + value[:count].to_s
  puts "Сумма: " + (value[:price] * value[:count]).to_s
  sum += value[:price] * value[:count]
  puts
end

puts "Общая сумма покупки: " + sum.to_s