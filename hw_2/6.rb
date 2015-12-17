order = {}
total = 0

while true
  puts "Введите название купленного товара или слово 'stop' для окончания ввода данных:"
  answer = gets.chomp
  break if answer == "stop"
  puts "Введите стоимость единицы товара:"
  cost = gets.chomp.to_f
  puts "Количество товара:"
  numbers = gets.chomp.to_f
  order[answer] = { price: cost, count: numbers }
end

puts "Куплены такие продукты:"
order.each do |product, values|
  puts "#{product}: #{values[:count]} шт. по цене #{values[:price]} за единицу;"
  total += values[:count]*values[:price]
end
puts "Всего потрачено: #{total}"

