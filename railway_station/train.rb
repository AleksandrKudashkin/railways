# encoding: utf-8
# frozen_string_literal: true
class Train
  include Manufacturer
  include InstanceCounter
  include Validator
  attr_reader :reg_number, :wagons, :speed, :current_station, :type
  NAME_PATTERN = /^[a-z0-9]{3}-*[a-z0-9]{2}$/i

  @@all_trains = {}

  def self.find(reg_number)
    @@all_trains.key?(reg_number) ? @@all_trains[reg_number] : nil
  end

  def initialize(reg_number)
    validate!(reg_number)

    @wagons = []
    @reg_number = reg_number
    @speed = 0
    @@all_trains[reg_number] = self
    @type = self.class

    register_instance
  end

  def speed_up
    self.speed += 10
  end

  def slow_down
    self.speed - 10 >= 0 ? self.speed -= 10 : self.speed = 0
  end

  def detach_wagon
    wagons.pop if self.speed == 0
  end

  def accept_route(route)
    self.route = route
    self.current_station = route.stations.first
  end

  def go_to(station)
    self.current_station = station if route.stations.include?(station)
  end

  def show_station(modifier)
    index = route.stations.find_index(current_station)

    puts route.stations[index + modifier.to_i].name
  end

  def each_wagon
    wagons.each_with_index { |w, i| yield(w, i) }
  end

  protected

  attr_writer :wagons, :speed, :current_station, :type
  attr_accessor :route

  def validate!(reg_number)
    raise "Train number must not be empty!" if reg_number.empty?
    raise "Train number must be in special format
           XXX-XX or XXXXX" if reg_number !~ NAME_PATTERN
    raise "The train number is not unique!
           Change it!" unless self.class.find(reg_number).nil?
    true
  end
end

class PassangerTrain < Train
  def attach_wagon(wagon)
    raise "Wagon's type mismatch!" if wagon.class != PassangerWagon
    raise "The train is moving! You should stop it first." if self.speed > 0
    wagons << wagon
  end
end

class CargoTrain < Train
  def attach_wagon(wagon)
    raise "Wagon's type mismatch" if wagon.class != CargoWagon
    raise "The train is moving! You should stop it first." if self.speed > 0
    wagons << wagon
  end
end
