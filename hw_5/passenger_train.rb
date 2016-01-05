# require_relative 'passenger_wagon'
require_relative 'train'

class PassengerTrain < Train
  
  protected
  
  def type
    :passenger
  end
  # def appropriate_wagon?(wagon)
  #   # wagon.instance_of?(PassengerWagon)
  #   wagon.type == type
  # end


  # def creare_wagon
  #   self.wagons << PassengerWagon.new
  # end
end