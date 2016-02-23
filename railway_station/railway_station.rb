class RailwayStation
  include Validator
  attr_reader :name

  @@instances = []
  NAME_PATTERN = /^[A-Z]{1}\w+/

  def self.all
    @@instances
  end

  def initialize(name)
    @name = name
    @trains = []
    @@instances << self
    validate!
  end

  def receive_train(train)
    self.trains << train #if train.current_station == self
    #TODO: add a function of add/remove/accept route in user interface
    self.show_all_trains
  end

  def show_all_trains
    self.trains.each { |t| 
      puts t.reg_number 
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

  def each_train
    self.trains.each { |t| yield(t) }
  end

  protected 
    #you can't have an access to trains directly
    attr_accessor :trains

    def validate!
      raise "Name is not set!" if self.name.empty?
      raise "Name must be at least of 2 symbols" if self.name.length < 2
      raise "Name is not correct. You should start with a capital letter." if self.name !~ NAME_PATTERN
      true
    end
end