class Wagon
  include Manufacturer

  def self.create(wagon_type)
     if wagon_type == :cargo
      CargoWagon.new                      
    elsif wagon_type == :passenger
      PassengerWagon.new
    else
    end
  end

  def type
  end
end