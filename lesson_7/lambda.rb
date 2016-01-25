# class Array
#   def iterate!(code)
#     self.each_with_index do |n, i|
#       self[i] = code.call(n)
#     end
#   end
# end

# array = [1, 2, 3, 4]

# array.iterate!(lambda { |n| n ** 2 })

# puts array.inspect # => [1, 4, 9, 16]

# ----------------------------------------------------------------------------------------------------------------------
#                                     lambdas check the number of arguments passed.
# def args(code)
#   one, two = 1, 2
#   code.call(one, two)
# end

# extra variables wil be seted to nil
# args(Proc.new{ |a, b, c| puts "Give me a #{a} and a #{b} and a #{c.class}" }) # => Give me a 1 and a 2 and a NilClass

# args(lambda{ |a, b, c| puts "Give me a #{a} and a #{b} and a #{c.class}" }) # *.rb:8: ArgumentError

# ----------------------------------------------------------------------------------------------------------------------
#                                    lambdas have diminutive returns

# while a Proc return will stop a method and return the value provided, 
# lambdas will return their value to the method and let the method continue on

# def proc_return
#   Proc.new { return "Proc.new" }.call
#   return "proc_return method finished"
# end

# def lambda_return
#   lambda { return "lambda" }.call
#   return "lambda_return method finished"
# end

# puts proc_return # => Proc.new
# puts lambda_return # => lambda_return method finished

# ----------------------------------------------------------------------------------------------------------------------

# def generic_return(code)
#   code.call
#   return "generic_return method finished"
# end

# arguments (a Proc in this example) cannot have a return keyword in it
# p generic_return(Proc.new { return "Proc.new" }) # => unexpected return (LocalJumpError)

# However, a lambda acts just like a method, which can have a literal return
# p generic_return(lambda { return "lambda" }) # => "generic_return method finished"

# ----------------------------------------------------------------------------------------------------------------------

# def generic_return(code)
#   one, two = 1, 2
#   three, four = code.call(one, two)
#   return "Give me a #{three} and a #{four}"
# end

# p generic_return(lambda { |x, y| return x+2, y+2 }) # => "Give me a 3 and a 4"
# p generic_return(Proc.new { |x, y| return x+2, y+2 }) # => unexpected return (LocalJumpError)
# p generic_return(Proc.new { |x, y| x+2 ; y+2 }) # => "Give me a 4 and a "
# p generic_return(Proc.new { |x, y| [x+2, y+2] }) # => "Give me a 3 and a 4"

# ----------------------------------------------------------------------------------------------------------------------
