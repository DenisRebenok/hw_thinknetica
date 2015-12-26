require_relative 'train'
require_relative 'passenger_wagon'


class PassengerTrain < Train
  def attach_wagon(wagon)
    attach_passenger_wagon(wagon)
  end

  private

  def attach_passenger_wagon(wagon)
    attach_wagon! if wagon.instance_of?(PassengerWagon)
  end
end