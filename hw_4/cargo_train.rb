require_relative 'train'
require_relative 'cargo_wagon'


class CargoTrain < Train
  def attach_wagon(wagon)
    attach_cargo_wagon(wagon)
  end

  private

  def attach_cargo_wagon(wagon)
    attach_wagon! if wagon.instance_of?(CargoWagon)
  end
end