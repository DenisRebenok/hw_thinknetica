require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'route'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'railway_station'
require_relative 'application'

def stations_full_report
  RailwayStation.all.each do |station|
    puts "RailwayStation #{station} include #{station.trains.size} trains:"
    station.each_train! do |train|
      puts " * #{train}:"
      train.each_wagon! { |wagon| puts "  - #{wagon}" }
    end
    puts
  end
end

def create_test_instances
  petrovka = RailwayStation.new("Petrovka")
  minskaya = RailwayStation.new("Minskaya")
  zona_51 = RailwayStation.new("Zona 51")

  train_777 = PassengerTrain.new('777-77', 7)
  train_2 = PassengerTrain.new('666-66', 13)
  train_4_vip = PassengerTrain.new('111-11', 2)
  cargo_12 = CargoTrain.new('111-12', 11)
  train_5 = PassengerTrain.new('111-13', 12)
  cargo_14 = CargoTrain.new('111-14', 20)
  train_15 = PassengerTrain.new('111-15', 13)

  cargo_14.wagons[13].take_volume(10)
  train_15.wagons[0].take_place(5)

  petrovka.arrive(train_777)
  petrovka.arrive(train_4_vip)
  petrovka.arrive(train_5)
  minskaya.arrive(train_2)
  minskaya.arrive(train_15)
  zona_51.arrive(cargo_12)
  zona_51.arrive(cargo_14)
end

create_test_instances
stations_full_report

app = Application.new
app.main