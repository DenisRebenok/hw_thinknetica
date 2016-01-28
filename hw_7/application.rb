class Application
  METHODS = 
  {"1" => :create_station, "2" => :create_train, "3" => :attach_wagons,  
    "4" => :detach_wagons, "5" => :train_wagons_list, "6" => :set_train_on_station, 
    "7" => :station_trains_list, "8" => :take_place, "h" => :print_help}

  MENU = 
    ["[1] Создать станцию", "[2] Создать поезд", "[3] Добавить вагон(ы) к поезду", 
    "[4] Отцепить вагон от поезда", "[5] Вывести список вагонов у поезда",
    "[6] Поместить поезд на станцию", "[7] Вывести список поездов на станции",
    "[8] Занять место или объем в вагоне", "[h] Справка", "[q] Выход с программы\n\n"]

  def initialize
    @stations = RailwayStation.all
    @trains = Train.all
  end

  def main
    print_help
    loop do
      print "\nДальнейшие действия? "
      answer = gets.chomp
      METHODS[answer] ? send(METHODS[answer]) : break
    end
  end

  private
  attr_accessor :trains, :stations
  
  def print_help
    puts "Варианты действий: "
    puts MENU
  end

  def create_station
    print "Название станции: "
    stations << RailwayStation.new(gets.chomp)
  rescue => e
    puts e.message
  end

  def create_train
    print "Тип поезда [cargo / passenger]: "
    type = gets.chomp.to_sym
    print "Номер поезда: "
    number = gets.chomp 
    trains[number] = Train.create(type, number, 0)
    
    attach_wagons(trains[number])
  rescue => e
    puts e.message
  end

  def set_train_on_station
    station_by_name.arrive(train_by_number)
  rescue => e
    puts e.message
  end

  def attach_wagons(train = nil)
    tries ||= 2
    train ||= train_by_number
    type = train.type
    print type == :passenger ? 'Количество мест в вагоне: ' : 'Общий объем вагона: '
    space = gets.to_i
    print "Количество вагонов: "
    wagons_count = gets.to_i
    wagons_count.times { train.attach_wagon( Wagon.create(type, space, train.wagons_amount+1) ) }
  rescue => e
    puts e.message
    retry unless (tries -= 1).zero?
  end

  def detach_wagons(train = nil)
    tries ||= 2
    train ||= train_by_number
    print "Количество отцепляемых вагонов: "
    wagons_count = gets.to_i
    wagons_count.times { train.detach_wagon }
  rescue => e
    puts e.message
    retry unless (tries -= 1).zero?
  end

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

  def train_wagons_list
    tries ||= 2
    train = train_by_number
    train.each_wagon! { |wagon| puts wagon }
  rescue => e
    puts e.message
    retry unless (tries -= 1).zero?
  end

  def station_trains_list
     tries ||= 2
     station = station_by_name
     station.each_train! { |train| puts train }
  rescue => e
    puts e.message
    retry unless (tries -= 1).zero?
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