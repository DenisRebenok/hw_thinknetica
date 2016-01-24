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


class Application
  def initialize
    @stations = []
    @trains = {}
  end

  def main
    print_help
    while true
      print "\nДальнейшие действия? "
      answer = gets.chomp
      case answer
      when "1"
        create_station
      when "2"
        create_train
      when "3"
        attach_wagon
      when "4"
        detach_wagon
      when "5"
        set_train_on_station
      when "6"
        stations_trains_list
      when "h"
        print_help
      else
        break
      end
    end
  end

  private
  attr_accessor :trains, :stations
  
  def print_help
    puts "Варианты действий: "
    puts "[1] Создать станцию"
    puts "[2] Создать поезд"
    puts "[3] Добавить вагоны к поезду"
    puts "[4] Отцепить вагон от поезда"
    puts "[5] Поместить поезд на станцию"
    puts "[6] Вывести список станций и поездов на них" 
    puts "[h] Справка"
    puts "[q] Выход с программы\n\n"
  end

  def create_station
    print "Название станции: "
    name = gets.chomp
    stations << RailwayStation.new(name)
  rescue => e
    puts e.message
  end

  def create_train
    print "Тип поезда [cargo / passenger]: "
    type = gets.chomp
    print "Номер поезда: "
    number = gets.chomp
    print "Количество вагонов: "
    wagons_amount = gets.to_i
    trains[number] = Train::create(type.to_sym, number, wagons_amount)
  rescue => e
    puts e.message
  end

  def attach_wagon
    tries ||= 2
    print "Train number: "
    number = gets.chomp
    train = trains[number]
    raise "Поезд не найден" unless train
    train.attach_wagon(Wagon::create(train.type))
  rescue => e
    puts e.message
    retry unless (tries -= 1).zero?
  end

  def detach_wagon
    tries ||= 2
    print "Train number: "
    number = gets.chomp
    train = trains[number]
    raise "Поезд не найден" unless train
    train.detach_wagon
  rescue => e
    puts e.message
    retry unless (tries -= 1).zero?
  end

  def stations_trains_list
    stations.each do |station|
      puts "Station #{station.name} contains #{station.trains.size} trains."
      station.trains.each { |tr| puts "#{tr.class} № #{tr.number}" }
    end
  end

  def set_train_on_station
    print "Номер поезда: "
    train_number = gets.chomp
    train = trains[train_number]
    raise "Поезд не найден" unless train  
    print "Название станции: "
    st_name = gets.chomp.capitalize
    st_index = stations.index { |station|  station.name == st_name }
    raise "No station named #{st_name}." unless st_index
    stations[st_index].arrive(train)
  rescue => e
    puts e.message
  end
end

app = Application.new
app.main