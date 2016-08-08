class RailwayStation < ActiveRecord::Base
  validates :title, presence: true
  has_many :railway_stations_routes
  has_many :routes, through: :railway_stations_routes
  has_many :trains

  def get_position(route)
    self.railway_stations_routes.find_by_route_id(route).number
  end

  def update_position(route, number)
    relation = self.railway_stations_routes.find_by_route_id(route)
    relation.number = number
    relation.save
  end
end
