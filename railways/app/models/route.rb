class Route < ActiveRecord::Base
  has_many :railway_stations_routes
  has_many :railway_stations, through: :railway_stations_routes
  has_many :trains

  validates :name, presence: true
  validate :stations_count
    
  before_validation :set_name

  private
    def stations_count
      if railway_stations.size < 2
        errors.add(:base, "A route must contain at least 2 railway stations")
      end
    end
    
    def set_name
      if self.name.blank? && (railway_stations.first.title != railway_stations.last.title)
        self.name = "#{railway_stations.first.title} - #{railway_stations.last.title}" 
      end
    end
end
