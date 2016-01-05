require_relative 'passenger_wagon'
require_relative 'train'

class PassengerTrain < Train
  protected
  
  def appropriate_wagon?(wagon)
    wagon.instance_of?(PassengerWagon)
  end

  # def creare_wagon
  #   self.wagons << PassengerWagon.new
  # end
end