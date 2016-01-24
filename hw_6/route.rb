class Route
  attr_reader :stations

  def initialize(first, last)
    @stations = [first, last] if valid?(first) && valid?(last)
  end

  def valid?(station)
    validate!(station)
  rescue
    false
  end

  def add_station(station)
    stations.insert(1, station) if valid?(station)
  end
  
  def delete_station(station)
    validate!(station)
    raise "Route must contain at least 2 stations!" if stations.size==2
    stations.delete(station)
  rescue
    false
  end

  # def stations_list
  #   stations.each { |station| puts station }
  # end

  protected

  def validate!(station)
    raise ArgumentError, "Station can't be nil" if station.nil?
    unless station.is_a?(RailwayStation)
      raise ArgumentError, "Unknown type of station"
    end
    true
  end
end