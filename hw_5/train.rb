class Train
  include Manufacturer
  
  @@trains = {}

  def self.find(number)
    @@trains[number]
  end
  
  attr_reader :number, :speed, :route

  def initialize(number, wagons_amount)
    @number = number
    @wagons = []
    @speed = 0
    add_wagons!(wagons_amount)
    @@trains[number] = self
  end

  def speed_up
    self.speed += 10
  end

  def speed_down
    self.speed -= 10 unless stopped? 
  end

  def stop
    self.speed = 0
    # current_station = route.stations[station_index] if route
  end
  
  def stopped?
    speed == 0
  end

  def wagons_amount
    wagons.size
  end

  def attach_wagon(wagon)
    attach_wagon!(wagon) if appropriate_wagon?(wagon)
  end

  def detach_wagon(wagon = nil)
    if stopped?
      if wagons_amount>0
        if wagon
          wagons.delete(wagon)
        else
          wagons.pop
        end
      else
        puts "Nothing to detach. No wagons."
      end
    else
      puts "Can't detach - train is moving. Stop train & try again."
    end
  end

  def set_route(route)
    if stopped?
      self.route = route
      station_index = 0
    end
  end

  def move_on
    station_index += 1 if route.stations[station_index+1]
  end

  def previos_station # может вынести в протектед или прайвет
    route.stations[station_index-1] if route && station_index>0
  end
  
  def current_station
    route.stations[station_index] if route
  end

  def next_station
    route.stations[station_index+1] if route
  end

  def start_station?
    route && previos_station.nil?
  end

  def final_station?
    route && next_station.nil?
  end

  def stations_info
    if route
      puts "Previos station: #{previos_station}" unless start_station?
      puts "Current station: #{current_station}"
      puts "Next station: #{next_station}" unless final_station?
    else
      puts "No routes."
    end               
  end

  def to_s
    "#{self.class} № #{number} с #{wagons_amount} вагонами (#{wagons})"
  end

  protected

  attr_writer :number, :speed
  attr_accessor :wagons, :station_index

  def type
  end

  def appropriate_wagon?(wagon)
    # wagon.instance_of?(Wagon) # и переопределить в потомках
    type && type==wagon.type
  end

  def attach_wagon!(wagon)
    if stopped?
      self.wagons << wagon
    else
      puts "Can't attach wagon - train is moving. Stop train & try again."
    end
  end

  def add_wagons!(wagons_amount)
    wagons_amount.times { self.wagons << Wagon::create(type) }
  end

  # def creare_wagon
  #   if self.instance_of?(CargoTrain)
  #     wagons << CargoWagon.new
  #   elsif self.instance_of?(PassengerTrain)
  #     wagons << PassengerWagon.new
  #   else
  #     wagons << Wagon.new
  #   end
  # end

end