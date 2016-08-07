class Route < ActiveRecord::Base
  validates :name, presence: true
  has_many :railway_stations_routes
  has_many :railway_stations, through: :railway_stations_routes
  has_many :trains

  before_validation :set_name

  private
    def set_name
      if self.name.blank?
        self.name = "#{railway_stations.first.title} - #{railway_stations.last.title}" 
      end
    end
end
