# encoding: utf-8
# frozen_string_literal: true
class RailwayStation
  include Validation
  attr_reader :name
  validate :name, :presence
  validate :name, :format, /^[a-z0-9]{3}-*[a-z0-9]{2}$/i

  @@instances = []

  def self.all
    @@instances
  end

  def initialize(name)
    @name = name.capitalize
    @trains = []
    @@instances << self
    validate!
  end

  def receive_train(train)
    trains << train # if train.current_station == self
    # maybe: add a function of add/remove/accept route in user interface
    show_all_trains
  end

  def show_all_trains
    trains.each do |t|
      puts t.reg_number
    end
  end

  def show_trains_by_type(type)
    trains.each do |t|
      puts t.reg_number if t.current_station == self && t.type == type
    end
  end

  def start_train(train)
    trains.delete(train)
  end

  def each_train
    trains.each { |t| yield(t) }
  end

  protected

  # you can't have an access to trains directly
  attr_accessor :trains

  #def validate!
  #  raise "Name is not set!" if name.empty?
  #  raise "Name must be at least of 2 symbols" if name.length < 2
  #  true
  #end
end
