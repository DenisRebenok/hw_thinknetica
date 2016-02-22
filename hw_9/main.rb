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

class TestClass
  def initialize
    @trains = {}
    create_test_trains
    create_test_stations
    @stations = RailwayStation.all
    arrive_trains
    take_space
  end

  def stations_full_report
    stations.each do |station|
      puts "RailwayStation #{station} include #{station.trains.size} trains:"
      station.each_train! do |train|
        puts " * #{train}:"
        train.each_wagon! { |wagon| puts "  - #{wagon}" }
      end
      puts
    end
  end

  private

  attr_accessor :trains, :stations

  def take_space
    trains['111-12'].wagons[1].take_volume(4)
    trains['111-11'].wagons[0].take_place(5)
  end

  def create_test_trains
    trains['777-77'] = PassengerTrain.new('777-77', 7, 11)
    trains['111-11'] = PassengerTrain.new('111-11', 2, 12)
    trains['111-12'] = CargoTrain.new('111-12', 11, 7)
    trains['111-13'] = PassengerTrain.new('111-13', 12, 10)
    trains['111-14'] = CargoTrain.new('111-14', 20, 5)
    trains['111-15'] = PassengerTrain.new('111-15', 13)
  end

  def create_test_stations
    RailwayStation.new('Petrovka')
    RailwayStation.new('Zona 51')
  end

  def arrive_trains
    stations[0].arrive(trains['777-77'])
    stations[0].arrive(trains['111-11'])
    stations[0].arrive(trains['111-13'])
    stations[0].arrive(trains['111-15'])
    stations[1].arrive(trains['111-12'])
    stations[1].arrive(trains['111-14'])
  end
end

test = TestClass.new
test.stations_full_report

app = Application.new
app.main
