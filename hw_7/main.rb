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
    @stations = RailwayStation.all
    @trains = Train.all
  end

  def main
    print_help
    loop do
      print "\nДальнейшие действия? "
      answer = gets.chomp
      case answer
      when "1"
        create_station
      when "2"
        create_train
      when "3"
        attach_wagons
      when "4"
        detach_wagons
      when "5"
        train_wagons_list
      when "6"
        set_train_on_station
      when "7"
        station_trains_list
      when "8"
        take_place
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
    puts "[3] Добавить вагон(ы) к поезду"
    puts "[4] Отцепить вагон от поезда"
    puts "[5] Вывести список вагонов у поезда"
    puts "[6] Поместить поезд на станцию"
    puts "[7] Вывести список поездов на станции"
    puts "[8] Занять место или объем в вагоне"
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
    type = gets.chomp.to_sym
    print "Номер поезда: "
    number = gets.chomp 
    trains[number] = Train.create(type, number, 0)
    print "Количество вагонов: "
    attach_wagons(trains[number], gets.to_i)
  rescue => e
    puts e.message
  end

  def attach_wagons(train = nil, wagons_count = 1)
    tries ||= 2
    train ||= train_by_number
    type = train.type
    # При создании вагона указывать кол-во мест или общий объем, в зависимости от типа вагона
    if type == :passenger
      print 'Количество мест в вагоне: '
    elsif type == :cargo
      print 'Общий объем вагона: '
    end
    space = gets.to_i
    wagons_count.times { train.attach_wagon( Wagon.create(type, space, train.wagons_amount+1) ) }
  rescue => e
    puts e.message
    retry unless (tries -= 1).zero?
  end

  def detach_wagons(wagons_count = 1)
    tries ||= 2
    train = train_by_number
    wagons_count.times { train.detach_wagon }
  rescue => e
    puts e.message
    retry unless (tries -= 1).zero?
  end

  # Вывести список вагонов у поезда
  def train_wagons_list
    tries ||= 2
    train = train_by_number
    train.each_wagon! { |wagon| puts wagon }
  rescue => e
    puts e.message
    retry unless (tries -= 1).zero?
  end

  # Выводить список поездов на станции
  def station_trains_list(station = nil)
     tries ||= 2
     station ||= station_by_name
     station.each_train! { puts train }
  rescue => e
    puts e.message
    retry unless (tries -= 1).zero?
  end

  # Занимать место или объем в вагоне
  def take_place
    tries ||= 2
    train = train_by_number
    print "Номер вагона: "
    wagon_number = gets.to_i
    if train.type == :passenger
      print 'Сколько занять мест в вагоне: '
      train.wagons[wagon_number-1].take_place(gets.to_i)
    elsif train.type == :cargo
      print 'Сколько занять объема вагона: '
      train.wagons[wagon_number-1].take_volume(gets.to_i)
    end
  rescue => e
    puts e.message
    retry unless (tries -= 1).zero?
  end

  def set_train_on_station
    station_by_name.arrive(train_by_number)
  rescue => e
    puts e.message
  end

  def train_by_number
    print "Номер поезда: "
    number = gets.chomp
    train = trains[number]
    raise "Поезд не найден" unless train
    train
  end

  def station_by_name
    print "Название станции: "
    st_name = gets.chomp.capitalize
    st_index = stations.index { |station|  station.name == st_name }
    raise "Станция #{st_name} не найдена." unless st_index
    stations[st_index]
  end
end

app = Application.new
app.main