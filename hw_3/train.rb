class Train
  # TRAIN_TYPES = [:freight, :passenger]
  attr_reader :type, :wagons_amount, :speed, :route

  def initialize(train_type, wagons_amount)
    @type = train_type
    @wagons_amount = wagons_amount
    @speed = 0
    @station_index = -1
  end
  
  def stopped? #OK
    speed == 0
  end

  def speed_up  #OK
    self.speed += 10
  end

  def speed_down  #OK
    self.speed -= 10 unless stopped? 
  end

  def stop
    self.speed = 0
    current_station = route.stations[station_index] if route
  end

  def atach_wagon #OK
    if stopped?
      wagons_amount += 1
    else
      puts "Can\t detach - train is moving. Stop train & try again."
    end
  end

  def detach_wagon  #OK
    if stopped?
      if wagons_amount>0
        wagons_amount -= 1
      else
        puts "Nothing to detach. No wagons."
      end
    else
      puts "Can\t detach - train is moving. Stop train & try again."
    end
  end

  def set_route(route)  #OK
    self.route = route
    station_index = 0
  end

  def move_on
    station_index += 1 if route.stations[station_index+1]
  end

  def previos_station
    route.stations[station_index-1]
  end
  
  def current_station
    route.stations[station_index]
  end

  def next_station
    route.stations[station_index+1]
  end

  def stations_info
    if route
      puts "Previos station: #{previos_station}" if previos_station
      puts "Current station: #{current_station}"
      puts "Next station: #{next_station}" if next_station
    else
      puts "No routes."
    end               
  end

  private

  attr_writer :speed, :wagons_amount
  attr_accessor :station_index
end