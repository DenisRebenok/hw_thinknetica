class Wagon
  include Manufacturer
  attr_reader :number

  def self.create(wagon_type, max_space = 10, number = 0)
     if wagon_type == :cargo
      CargoWagon.new(max_space, number)
    elsif wagon_type == :passenger
      PassengerWagon.new(max_space, number)
    else
    end
  end

  def initialize(max_space, number)
    @number = number
  end

  def to_s
    "#{type.to_s.capitalize} wagon № #{@number} has: "
  end

  def type
    :general
  end
end