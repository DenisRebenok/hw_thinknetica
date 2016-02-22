require_relative 'accessor'

class AccessorsTest
include Accessor

attr_accessor :a, :b, :c, :str

def initialize
  @a, @b, @c = 1, 2, 3
end 
end

test = AccessorsTest.new