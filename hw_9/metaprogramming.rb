require_relative 'accessor'
require_relative 'validation'

class Test
  include Accessor
  include Validation

  attr_accessor_with_history :a, :b, :c
  strong_attr_acessor :str, String

  validate :str, :presence
  validate :b, :type, String

  def initialize
    # @a = 1
    @b = 2
    @c = 3
    @str = ""

    validate!
  end
end