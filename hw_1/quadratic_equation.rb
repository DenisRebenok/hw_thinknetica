def get_discriminant(a, b, c)
  b*2 - 4*a*c
end


puts "Коэфициент а: "
a = gets.chomp.to_f
puts "Коэфициент b: "
b = gets.chomp.to_f
puts "Коэфициент c: "
c = gets.chomp.to_f

d = get_discriminant(a, b, c)
puts "Дискриминант: #{d}"
if d < 0
  puts "Корней нет."
elsif d > 0
  x1 = ( -1*b + Math.sqrt(d) ) / 2*a
  x2 = ( -1*b - Math.sqrt(d) ) / 2*a
  puts "Корни: #{x1}, #{x2}"
else
  puts "Корень: #{(-1*b/2*a)}" 
end




