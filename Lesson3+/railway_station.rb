class RailwayStation
  include Validator
  attr_reader :name

  @@instances = []
  NAME_PATTERN = /^[A-Z]{1}\w+/

  def self.all
    puts "Имеющиеся станции:"
    @@instances.each { |i|
      puts i.name
      puts "Поезда на станции:"
      i.show_all_trains
    }
  end

  def initialize(name)
    @name = name
    @trains = []
    @@instances << self
    validate!
  end

  def receive_train(train)
    self.trains << train #if train.current_station == self
    #комментарий стоит для проверки работы меню, в котором не учитываются маршруты, а только станции
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

  protected
    attr_accessor :trains
    #нельзя иметь доступ к поездам напрямую без методов

    def validate!
      raise "Name is not set!" if self.name.empty?
      raise "Name must be at least of 2 symbols" if self.name.length < 2
      raise "Name is not correct. You should start with a capital letter." if self.name !~ NAME_PATTERN
      true
    end
end