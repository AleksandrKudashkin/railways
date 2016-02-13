class Route
  include Validator

  def initialize(first_station, last_station)
    @stations = []
    @stations << first_station
    @stations << last_station
    validate!
  end

  def add_station(station)
    raise "You can only add a RailwayStation object to the route!" if station.class != RailwayStation
    self.stations.insert(1, station)
  end

  def delete_station(station)
    self.stations.delete(station)
  end

  def list
    self.stations.each { |s|
      puts s.name
    }
  end

  protected 
    attr_accessor :stations

    def validate!
      raise "Station(s) does not exist! You must create it first!" if @stations[0].class != RailwayStation
      true
    end
end