class RailwayStationsRoute < ActiveRecord::Base
  belongs_to :railway_station
  belongs_to :route

  validates :railway_station_id, uniqueness: { scope: :route_id }
  validates :position, numericality: { only_integer: true }, allow_blank: true
  validates_time :departure_time, :arrival_time, allow_blank: true
end
