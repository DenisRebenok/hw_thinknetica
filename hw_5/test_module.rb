require_relative 'instance_counter'

class TestCounter
  include InstanceCounter
  
  def initialize
    register_instance
  end
end