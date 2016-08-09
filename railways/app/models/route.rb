class Route < ActiveRecord::Base
  has_many :railway_stations_routes
  has_many :railway_stations, through: :railway_stations_routes
  has_many :trains

  validates :name, presence: true, length: { in: 5..65 }, format: { with: /\A[a-zA-Z-\s0-9]+\z/,
        message: "only allows letters, numbers, spaces and dashes" }
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
