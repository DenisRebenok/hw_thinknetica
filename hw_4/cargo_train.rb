require_relative 'train'
require_relative 'cargo_wagon'


class CargoTrain < Train
  def atach_wagon(wagon)
    attach_wagon! if wagon.instance_of?(CargoWagon)
  end
end