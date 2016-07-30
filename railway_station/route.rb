# encoding: utf-8
# frozen_string_literal: true
class Route
  include Validation
  validate :first_station, :presence
  validate :first_station, :type, RailwayStation
  validate :last_station, :presence
  validate :last_station, :type, RailwayStation

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = []
    @stations << @first_station
    @stations << @last_station
    validate!
  end

  def add_station(station)
    raise "You can only add a RailwayStation object
           to the route!" if station.class != RailwayStation
    stations.insert(1, station)
  end

  def delete_station(station)
    stations.delete(station)
  end

  def list
    stations.each do |s|
      puts s.name
    end
  end

  protected

  attr_accessor :stations
end
