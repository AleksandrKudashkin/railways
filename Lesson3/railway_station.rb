class RailwayStation
  attr_reader :name
  attr_accessor :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def receive_train(train)
    self.trains << train if train.current_station == self
    self.show_all_trains
  end

  def show_all_trains
    self.trains.each { |t| 
      puts t.reg_number if t.current_station == self
    }
  end

  def show_trains_by_type(type)
    self.trains.each { |t| 
      puts t.reg_number if t.current_station == self && t.type == type
    }
  end

  def start_train(train)
    self.trains.delete(train)
  end
end