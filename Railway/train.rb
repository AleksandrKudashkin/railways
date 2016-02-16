class Train
  include Manufacturer
  include InstanceCounter
  include Validator
  attr_reader :reg_number, :wagons, :speed, :current_station
  NAME_PATTERN = /^[a-z0-9]{3}-*[a-z0-9]{2}$/i

  @@all_trains = {}

  def self.find(reg_number)
    @@all_trains.has_key?(reg_number) ? @@all_trains[reg_number] : nil
  end
    
  def initialize(reg_number)
    validate!(reg_number)
    
    @wagons = []
    @reg_number = reg_number
    @speed = 0
    @@all_trains[reg_number] = self
   
    register_instance
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

  def each_wagon
    self.wagons.each { |w| yield(w) }
  end

  protected
    attr_writer :wagons, :speed, :current_station 
    attr_accessor :route

    def validate!(reg_number)
      raise "Train number must not be empty!" if reg_number.empty?
      raise "Train number must be in special format XXX-XX or XXXXX" if reg_number !~ NAME_PATTERN
      raise "The train number is not unique! Change it!" unless self.class.find(reg_number).nil?
      true
    end
end

class PassangerTrain < Train
  attr_reader :type

  def initialize(reg_number)
    super
    @type = 1
  end

  def attach_wagon(wagon)
    raise "Wagon's type mismatch!" if wagon.class != PassangerWagon
    raise "The train is moving! You should stop it first." if self.speed > 0
    self.wagons << wagon 
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
    raise "Wagon's type mismatch" if wagon.class != CargoWagon
    raise "The train is moving! You should stop it first." if self.speed > 0
    self.wagons << wagon 
  end

  private
    attr_writer :type
end