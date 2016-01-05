class Wagon
  include Manufacturer

  def self.create(wagon_type)
    # возможно стоит избавиться от использования дочерних классов внутри родительских
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