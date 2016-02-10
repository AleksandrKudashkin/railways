class Train
  include Manufacturer
  attr_reader :reg_number, :wagons, :speed, :current_station
    
  def initialize(reg_number)
    @wagons = []
    @reg_number = reg_number
    @speed = 0
  end

  def speed_up
    self.speed += 10
  end

  def slow_down
    self.speed - 10 >= 0 ? self.speed -= 10 : self.speed = 0
  end

  def detach_wagon
    self.wagons.pop if self.speed == 0
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

  protected
    attr_writer :wagons, :speed, :current_station 
    #нельзя эти данные менять напрямую
    attr_accessor :route
    #напрямую роут вообще не должен быть доступен 
end

class PassangerTrain < Train
  attr_reader :type

  def initialize(reg_number)
    super
    @type = 1
  end

  def attach_wagon(wagon)
    self.wagons << wagon if wagon.class == PassangerWagon
  end

  private
    attr_writer :type
end

class CargoTrain < Train
  attr_reader :type

  def initialize(reg_number)
    super
    @type = 2
  end

  def attach_wagon(wagon)
    self.wagons << wagon if wagon.class == CargoWagon
  end

  private
    attr_writer :type
end