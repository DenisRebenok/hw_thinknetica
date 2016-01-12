require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'route'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'railway_station'


class Application
  def main
    print_help
    while true
      print "Дальнейшие действия? "
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
      when "q"
        break
      else
        print_help
      end
    end
  end

  private
  attr_accessor :trains, :stations

  def initialize
    @stations =[]
    @trains = []
  end

  def print_help
    puts "Варианты дейсвий: "
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
  end

  def create_train
    print "Тип поезда [:cargo/:passenger]: "
    type = gets.chomp
    print "Количество вагонов: "
    wagons_amount = gets.to_i
    if type == :passenger || type == "passenger"
      trains << PassengerTrain.new(wagons_amount)
    elsif type == :cargo || type == "cargo"
      trains << CargoTrain.new(wagons_amount)
    else
      trains << Train.new(wagons_amount)
    end
  end

  def attach_wagon
    # puts "Сколько вагонов добавить?"
    print "Train number: "
    train_index = gets.to_i
    train = trains[train_index]
    if train
      if train.instance_of?(CargoTrain)
        train.attach_wagon(CargoWagon.new)
      elsif train.instance_of?(PassengerTrain)
        train.attach_wagon(PassengerWagon.new)
      else
        train.attach_wagon(Wagon.new)
      end
    else
      puts "Поезд не найден"
    end
  end

  def detach_wagon(wagon = nil)
    print "Train number: "
    train_index = gets.to_i
    train = trains[train_index]
    if train 
      train.detach_wagon(wagon)
      puts "От поезда отцепили один вагон. Поезд остался с #{train.wagons_amount} вагонами."
    end
  end

  def stations_trains_list
    stations.each do |station|
      puts "Station #{station} contains #{station.trains.size} trains."
      station.all_trains
    end
  end

  def set_train_on_station
    print "Номер поезда(индекс): "
    tr_index = gets.to_i
    train = trains[tr_index]
    unless train
      puts "Поезд не найден"
      return
    end   
    print "Название станции: "
    st_name = gets.chomp
    st_index = -1
    stations.each_with_index { |station, index|  st_index = index if station.name == st_name }
    unless st_index < 0
      stations[st_index].arrive(train)
    else
      puts "No station named #{st_name}."
    end
  end
end

app = Application.new
app.main