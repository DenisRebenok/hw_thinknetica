class Train
  include Manufacturer
  include InstanceCounter

  NUMBER_FORMAT = /^[а-яa-z\d]{3}-?[а-яa-z\d]{2}$/i
  
  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def self.all
    @@trains
  end

  def self.create(type, number, wagons_amount = 0)
    if type == :cargo
      CargoTrain.new(number, wagons_amount)
    elsif type == :passenger
      PassengerTrain.new(number, wagons_amount)
    else
    end
  end
  
  attr_reader :number, :speed, :route

  def initialize(number, wagons_amount = 0)
    @number = number
    @wagons = []
    validate!
    @speed = 0
    add_wagons!(wagons_amount) if wagons_amount > 0
    @@trains[number] = self
    register_instance
  end

  def valid?
    validate!
  rescue
    false
  end

  def speed_up
    self.speed += 10
  end

  def speed_down
    self.speed -= 10 unless stopped? 
  end

  def stop
    self.speed = 0
  end
  
  def stopped?
    speed == 0
  end

  def wagons_amount
    wagons.size
  end

  def attach_wagon(wagon)
    validate_hooking!
    validate_wagon!(wagon)
    attach_wagon!(wagon)
  rescue
    false
  end

  def detach_wagon(wagon = nil)
    validate_hooking!
    raise "No wagons to detach." if wagons_amount.zero?
    if wagon
      # validate_wagon!(wagon)
      raise "A wagon are not attached to a train!" unless wagons.include?(wagon)
      wagons.delete(wagon)
    else
      wagons.pop
    end
  rescue
    false 
  end

  def set_route(route)
    validate_route!(route)
    self.route = route
    station_index = 0
  rescue
    false
  end

  def move_on
    station_index += 1 if route.stations[station_index+1]
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

  def type
  end
  
  protected

  attr_writer :number, :speed
  attr_accessor :wagons, :station_index

  def validate!
    raise "Number can't be nil" if number.nil?
    # raise "Number should be in string format" unless number.is_a?(String)
    # raise "Number should contain 5 or 6 symbols" if number.length != 5
    raise "Train number has invalid format" if number !~ NUMBER_FORMAT

    raise "Wagons amount can't be nil" if wagons_amount.nil?
    raise "Wagons amount should be in Fixnum (Integer) format" unless wagons_amount.is_a?(Fixnum)
    # raise "Train should contain at least one wagon" if wagons_amount < 1
    true
  end

  def validate_number!
    raise "Train with this number have been created before" if trains.has_key?(number)
    true
  end

  def validate_wagon!(wagon)
    raise ArgumentError, "Unsupported type of wagon." unless appropriate_wagon?(wagon)
    true
  end

  def validate_hooking!
    raise "Train is moving. Stop it & retry." unless stopped?
    true
  end

  def validate_route!(route)
    raise ArgumentError, "Unsupported type. Must be a Route object!"
  end

  def previos_station
    route.stations[station_index-1] if route && station_index>0
  end
  
  def current_station
    route.stations[station_index] if route
  end

  def next_station
    route.stations[station_index+1] if route
  end

  def appropriate_wagon?(wagon)
    type && type==wagon.type
  end

  def attach_wagon!(wagon)
    self.wagons << wagon if stopped?
  end

  def add_wagons!(wagons_amount)
    wagons_amount.times { self.wagons << Wagon::create(type) }
  end
end