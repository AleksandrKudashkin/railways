class RailwayStation < ActiveRecord::Base
  validates :title, presence: true, length: { in: 2..30 }, format: { with: /\A[a-zA-Z]+\z/,
        message: "only allows letters" }

  has_many :railway_stations_routes
  has_many :routes, through: :railway_stations_routes
  has_many :trains
  
  scope :sorted, -> { 
    includes(:railway_stations_routes).order('railway_stations_routes.number') 
  }

  def get_position(route)
    station_route(route).try(:number)
  end

  def update_position(route, number)
    station_route = station_route(route)
    station_route.update(number: number) if station_route
  end

  protected

    def station_route(route)
      @station_route ||= railway_stations_routes.where(route: route).first
    end
end
