class RailwayStation
  @@stations = []

  def self.all
  @@stations
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
      trains.map { |train| train if train.type == train_type }.compact
    else
      trains
    end
  end

  def to_s
    name
  end
  
  private

  attr_writer :trains

  def validate!
    raise "Station name can't be nil" if name.nil?
    raise "Station name must be in string format" unless name.is_a?(String)
    true
  end

  def train_valid?(train)
    raise ArgumentError, "Unknonwn type of Train" unless train.is_a?(Train)
    true
  rescue 
    false
  end
end