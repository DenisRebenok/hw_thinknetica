class Route
  attr_reader :stations

  def initialize(first, last)
    @stations = [first, last]
  end

  def add_station(station)
    stations.insert(1, station)
  end
  
  def delete_station(station)
    if stations.size > 2
      stations.delete(station)
    else
      puts "Can\'t delete station. Only 2 stations. Add another one and try to delete station again"
    end
  end

  def list_all_stations
    stations.each { |station| puts station.name }
  end
end