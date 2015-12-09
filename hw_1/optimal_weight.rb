puts "Ваше имя?"
name = gets.chomp
puts "Ваш рост?"
stature = gets.chomp.to_i

optimal_weight = stature - 110

if optimal_weight > 0
  puts "#{name}, ваш идеальный вес: #{optimal_weight} кг."
else
  puts "Ваш вес уже оптимальный"
end