order = {}

while true
  puts "Введите название купленного товара или слово 'stop' для окончания ввода данных:"
  answer = gets.chomp
  break if answer == "stop"
  puts "Введите стоимость единицы товара:"
  cost = gets.to_f
  puts "Количество товара:"
  numbers = gets.to_f
  order[answer] = { price: cost, count: numbers }
end

puts "Куплены такие продукты:"
total = 0
order.each do |product, values|
  product_total = values[:count] * values[:price]
  puts "#{product}: #{values[:count]} шт/кг/л. Стоимость: #{product_total};"
  total += product_total
end
puts "Общая стоимость заказа: #{total}"

