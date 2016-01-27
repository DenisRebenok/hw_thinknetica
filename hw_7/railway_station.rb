class RailwayStation
  @@stations = []

  def self.all
    @@stations
  end

  # написать код, который перебирает последовательно все станции
  def self.stations_trains_info
    @@stations.each do |station|
      trains = station.trains
      puts "Station #{station} include #{trains.size} trains."
      # и для каждой станции выводит список поездов в формате:
      # Номер поезда, тип, кол-во вагонов (Train#to_s)
      station.each_train! { |train| puts train }# if trains.any?
    end
  end

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @name = @name.capitalize.chomp if validate!
    @trains = []
    @@stations << self
  end

  def valid?
    validate!
  rescue
    false
  end
  
  def arrive(train)
    self.trains << train if train_valid?(train)
  end

  def departure(train)
    # raise "No trains on a station." if trains.empty?
    trains.delete(train) if trains.any? && train_valid?(train)
  rescue
    false
  end

  def get_trains(train_type = nil)
    if train_type
      # trains.map { |train| train if train.type == train_type }.compact
      trains.select { |train| train.type == train_type }
    else
      trains
    end
  end

  def each_train!
    trains.each { |train| yield(train) }
  end

  def trains_wagons_info
    trains.each do |train|
      puts train
      train.wagons.each_wagon! { |wagon| puts wagon }
    end
  end

  # def print_trains_info
  #   each_train! { puts train }
  # end

  def to_s
    name
  end
  
  private

  attr_writer :trains

  def validate!
    raise ArgumentError, "Station name can't be nil" if name.nil?
    raise ArgumentError, "Station name must be in string format" unless name.is_a?(String)
    true
  end

  def train_valid?(train)
    raise ArgumentError, "Unknonwn type of Train" unless train.is_a?(Train)
    true
  rescue 
    false
  end
end