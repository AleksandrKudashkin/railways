class Route
  attr_accessor :stations

  def initialize(first_station, last_station)
    @stations = Array.new
    @stations << first_station
    @stations << last_station
  end

  def add_station(station)
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
end