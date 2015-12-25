class Train
  attr_reader :wagons_amount, :speed, :route

  def initialize(wagons_amount)
    @wagons_amount = wagons_amount
    @speed = 0
    @station_index = -1
  end

  def speed_up
    self.speed += 10
  end

  def speed_down
    self.speed -= 10 unless stopped? 
  end

  def stop
    self.speed = 0
    current_station = route.stations[station_index] if route
  end
  
  def stopped?
    speed == 0
  end

  def attach_wagon
    attach_wagon!
  end

  def detach_wagon
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

  def set_route(route)
    if stopped?
      self.route = route
      station_index = 0
    end
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

  def start_station?
    previos_station.nil?
  end

  def final_station?
    next_station.nil?
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

  protected
  # пользователь не должен видеть внутренюю механику объекта (вспомогательные методы и аттрибуты)
  # и не должен на нее влиять, чтобы не создать в работе объекта ошибку и не запутать самого себя :)

  # пользователь не должен иметь возможность произвольно менять количество вагонов, скорость поезда, 
  # так как существуют публичные методы (attach_wagon, detach_wagon, speed_up, speed_down),
  # которые выполняют нужные действия более естественно, т.е. аналогично объектам реального мира
  attr_writer :speed, :wagons_amount 

  # индекс текущей станции, - внутрений метод для быстого нахождения текущей станции
  # пользователю предоставлены 4 публичных метода для ознакомления с положением поезда в дороге
  attr_accessor :station_index

  def attach_wagon!
    if stopped?
      self.wagons_amount += 1
    else
      puts "Can\t detach - train is moving. Stop train & try again."
    end
  end
end