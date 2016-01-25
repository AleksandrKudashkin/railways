class Train
  attr_accessor :wagons
  attr_accessor :speed
  attr_accessor :current_station
  attr_accessor :route

  attr_reader :reg_number
  attr_reader :type

  def initialize(reg_number, type, wagons)
    @wagons = wagons
    @reg_number = reg_number
    @type = type
    @speed = 0
  end

  def speed_up
    self.speed += 10
  end

  def slow_down
    self.speed - 10 >= 0 ? self.speed -= 10 : self.speed = 0
  end

  def attach_wagon
    self.wagons += 1 if self.speed == 0
  end

  def detach_wagon
    self.wagons -= 1 if self.speed == 0
  end

  def accept_route(route)
    self.route = route
    self.current_station = route.stations.first
  end

  def go_to(station)
    self.current_station = station if self.route.stations.include?(station)
  end

  def show_station(modifier)
    index = self.route.stations.find_index(self.current_station)

    puts self.route.stations[index+modifier.to_i].name 
  end
end