puts "Введите год (гггг): "
year = gets.chomp.to_i

puts "Введите месяц (мм): "
month = gets.chomp.to_i

puts "Введите число (дд): "
day = gets.chomp.to_i

months = {
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

months[2] = 29 if (year % 4 == 0) && (year % 100 != 0 || year % 400 == 0)

result = day
for i in 1..month do 
  result += months[i] if i < month
end

puts "Порядковый номер даты: " + result.to_s