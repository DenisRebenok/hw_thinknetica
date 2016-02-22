class Wagon
  include Manufacturer
  attr_reader :number, :type

  def self.create(wagon_type, number = 0, max_space = 10)
    if wagon_type == :cargo
      CargoWagon.new(number, max_space)
    elsif wagon_type == :passenger
      PassengerWagon.new(number, max_space)
    end
  end

  def to_s
    "#{type.to_s.capitalize} wagon № #{@number}"
  end
end
