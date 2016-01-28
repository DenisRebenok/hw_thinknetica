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


def create_test_instances
  station_1 = RailwayStation.new("Minskaya")
  station_2 = RailwayStation.new("Stoli4naya")
  station_3 = RailwayStation.new("Zona 51")

  train_1 = PassengerTrain.new('777-77', 7)
  train_2 = PassengerTrain.new('666-66', 13)
  train_3 = PassengerTrain.new('111-11', 10)
  train_4 = CargoTrain.new('111-12', 11)
  train_5 = PassengerTrain.new('111-13', 12)
  train_6 = CargoTrain.new('111-14', 20)
  train_7 = PassengerTrain.new('111-15', 13)

  station_1.arrive(train_1)
  station_1.arrive(train_3)
  station_1.arrive(train_5)
  station_2.arrive(train_2)
  station_2.arrive(train_7)
  station_3.arrive(train_4)
  station_3.arrive(train_6)
end

create_test_instances

app = Application.new
app.stations_full_report
app.main