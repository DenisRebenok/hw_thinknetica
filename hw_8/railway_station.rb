class RailwayStation
  @stations = []

  class << self; attr_accessor :stations end

  def self.all
    @stations
  end

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @name = @name.capitalize.chomp if validate!
    @trains = []
    self.class.stations << self
  end

  def valid?
    validate!
  rescue
    false
  end

  def arrive(train)
    trains << train if train_valid?(train)
  end

  def departure(train)
    trains.delete(train) if trains.any? && train_valid?(train)
  end

  def get_trains(train_type = nil)
    train_type ? trains.select { |train| train.type == train_type } : trains
  end

  def each_train!
    trains.each { |train| yield(train) }
  end

  def to_s
    name
  end

  private

  attr_writer :trains

  def validate!
    fail ArgumentError, "Station name can't be nil!" if name.nil?
    fail ArgumentError, 'Station name is a string!' unless name.is_a?(String)
    true
  end

  def train_valid?(train)
    fail ArgumentError, 'Unknonwn type of Train' unless train.is_a?(Train)
    true
  rescue
    false
  end
end
