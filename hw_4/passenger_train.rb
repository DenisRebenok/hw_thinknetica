require_relative 'train'
require_relative 'passenger_wagon'


class PassengerTrain < Train
  def atach_wagon(wagon)
    attach_wagon! if wagon.instance_of?(PassengerWagon)
  end
end