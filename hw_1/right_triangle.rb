def has_3_equal_sides?(sides)
  a, b, c = sides
  a == b and b == c
end

def with_equal_cathets?(sides)
  a, b, c = sides
  a==b or b==c or a==c
end

def is_right_triangle?(sides)
  sides.sort!
  cathet_1 = sides[0]
  cathet_2 = sides[1]
  hypotenuse = sides[2]
  hypotenuse**2 == (cathet_1**2 + cathet_2**2)
end


sides = []

1.upto(3) do |i|
  puts "Какая длина #{i} стороны треугольника?"
  sides << gets.chomp.to_f
end

unless has_3_equal_sides?(sides)
  simple_triangle = true
  
  if is_right_triangle?(sides)
    puts "Треугольник прямоугольный"
    simple_triangle = false
  end
  
  if with_equal_cathets?(sides)
    puts "Треугольник равнобедренный" 
    simple_triangle = false
  end

  puts "Треугольник обычный" if simple_triangle
else
  puts "Правильный (равностороний) треугольник"
end
