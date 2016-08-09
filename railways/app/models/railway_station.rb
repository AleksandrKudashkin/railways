class RailwayStation < ActiveRecord::Base
  validates :title, presence: true, length: { in: 2..30 }, format: { with: /\A[a-zA-Z]+\z/,
        message: "only allows letters" }

  has_many :railway_stations_routes
  has_many :routes, through: :railway_stations_routes
  has_many :trains
  
  scope :sorted, ->(route) { 
    includes(:railway_stations_routes).where('railway_stations_routes.route_id = ?', route.id).order('railway_stations_routes.number') 
  }

  def get_position(route)
    self.railway_stations_routes.find_by_route_id(route).number
  end

  def update_position(route, number)
    if number.to_i.between?(1, 1000)
      relation = self.railway_stations_routes.find_by_route_id(route)
      relation.number = number
      relation.save
    end
  end
end
