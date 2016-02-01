class Train
  include Manufacturer
  include InstanceCounter

  NUMBER_FORMAT = /^[а-яa-z\d]{3}-?[а-яa-z\d]{2}$/i

  @trains = {}

  class << self; attr_accessor :trains end

  def self.find(number)
    @trains[number] if @trains
  end

  def self.create(type, number, wagons_amount = 0, wagons_space = 10)
    if type == :cargo
      CargoTrain.new(number, wagons_amount, wagons_space)
    elsif type == :passenger
      PassengerTrain.new(number, wagons_amount, wagons_space)
    end
  end

  attr_reader :type, :number, :speed, :route, :wagons, :current_station

  def initialize(number, wagons_amount = 0, wagons_space = 10)
    @number = number
    @wagons = Array.new(wagons_amount) { |n| Wagon.create(type, n + 1, wagons_space) }
    validate!
    @speed = 0
    self.class.trains[number] = self
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
    self.speed -= 10 if speed >= 10
  end

  def stop
    self.speed = 0
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
    fail 'No wagons to detach.' if wagons_amount.zero?
    if wagon
      fail 'A wagon are not attached to a train!' unless wagons.include?(wagon)
      wagons.delete(wagon)
    else
      wagons.pop
    end
  rescue
    false
  end

  def route=(route)
    validate_route!(route)
    self.route = route
    self.current_station = route.stations.first
    route.stations.first.arrive(self)
  rescue
    false
  end

  def move_on
    self.current_station = next_station
  end

  def stations_info
    if route
      puts "Previos station: #{previos_station}" if previos_station
      puts "Current station: #{current_station}"
      puts "Next station: #{next_station}" if next_station
    else
      puts 'No routes.'
    end
  end

  def each_wagon!
    wagons.each { |wagon| yield(wagon) }
  end

  def to_s
    "#{type.to_s.capitalize} train № #{number} has #{wagons_amount} wagons"
  end

  protected

  attr_writer :number, :speed, :wagons, :route, :current_station

  def validate!
    fail "Train number can't be nil" if number.nil?
    fail 'Train number has invalid format' if number !~ NUMBER_FORMAT
    fail 'Train with this number already created' if self.class.find(number)
    fail "Wagons amount can't be nil" if wagons_amount.nil?
    fail 'Wagons amount is a Fixnum!' unless wagons_amount.is_a?(Fixnum)
    true
  end

  def appropriate_wagon?(wagon)
    wagon.is_a?(Wagon) && type == wagon.type
  end

  def validate_wagon!(wagon)
    fail 'Unsupported type of wagon.' unless appropriate_wagon?(wagon)
    true
  end

  def validate_hooking!
    fail 'Train is moving. Stop it & retry.' if speed > 0
    true
  end

  def validate_route!(route)
    fail ArgumentError, 'Unsupported type. Must be a Route object!' unless route.is_a?(Route)
  end

  def previos_station
    route.stations[route.stations.index(current_station) - 1] if route
  end

  def current_station=(station)
    current_station.departure(self) if current_station
    self.current_station = station
    current_station.arrive(self)
  end

  def next_station
    route.stations[route.stations.index(current_station) + 1] if route
  end

  def attach_wagon!(wagon)
    wagons << wagon if speed == 0
  end
end
