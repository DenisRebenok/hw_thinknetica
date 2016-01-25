class Array
  def iterate!(code)
    self.each_with_index do |n, i|
      self[i] = code.call(n)
    end
  end
end

def square(n)
  n ** 2
end
puts method(:square).class

array = [1, 2, 3, 4]

array.iterate!(method(:square))

puts array.inspect