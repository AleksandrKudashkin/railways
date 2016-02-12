class RailwayStation
  @@instances = []

  def self.all
    puts "Имеющиеся станции:"
    @@instances.each { |i|
      puts i.name
      puts "Поезда на станции:"
      i.show_all_trains
    }
  end

  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
    @@instances << self
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
end