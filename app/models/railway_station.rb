class RailwayStation < ActiveRecord::Base
  ALLOWED_ATTR = %w(position arrival_time departure_time)

  validates :title, presence: true, length: { in: 2..30 }, format: { with: /\A[a-zA-Z]+\z/,
        message: "only allows letters" }

  has_many :railway_stations_routes
  has_many :routes, through: :railway_stations_routes
  has_many :trains, foreign_key: :current_station_id
  
  scope :sorted, -> { 
    includes(:railway_stations_routes).order('railway_stations_routes.position') 
  }

  def position(route)
    station_route(route).try(:position)
  end
  
  def departure_time(route)
    time = station_route(route).try(:departure_time)
    time.strftime("%H:%M") if time
  end

  def arrival_time(route)
    time = station_route(route).try(:arrival_time)
    time.strftime("%H:%M") if time
  end

  def update_special(route, params)
    station_route = station_route(route)
    if station_route
      @params_for_update = {}
      params.each { |k, v| @params_for_update[k] = v if ALLOWED_ATTR.include?(k) }
      station_route.update(@params_for_update)
    end
  end

  protected

    def station_route(route)
      @station_route ||= railway_stations_routes.where(route: route).first
    end
end
