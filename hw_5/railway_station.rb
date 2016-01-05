class RailwayStation
  @@stations = []

  def self.all
  @@stations.each { |station| puts station }
  end

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
  end
  
  def arrive(train)
    trains << train
  end

  def departure(train)
    unless trains.empty?
      trains.delete(train)
    else
      puts "No trains on a station."
    end
  end

  def all_trains
    trains.each { |train| puts train }
  end

  def list_trains(train_type)
    if trains.empty?
      puts "No trains on a station."
    else
      spec_trains = trains.select { |train| train if train.type == train_type }
      unless spec_trains.empty?
        spec_trains.each { |train| puts train }
      else
        puts "No trains that match condition of type."
      end
    end
  end

  def to_s
    name
  end
  
  private

  attr_writer :trains
end