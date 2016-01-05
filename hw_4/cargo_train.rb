require_relative 'cargo_wagon'
require_relative 'train'

class CargoTrain < Train
  protected

  def appropriate_wagon?(wagon)
    wagon.instance_of?(CargoWagon)
  end

  # def creare_wagon
  #   self.wagons << CargoWagon.new
  # end
end