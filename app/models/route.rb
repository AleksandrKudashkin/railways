class Route < ActiveRecord::Base
  has_many :railway_stations_routes
  has_many :railway_stations, through: :railway_stations_routes
  has_many :trains

  validates :name, presence: true, length: { in: 5..65 }, format: { with: /\A[a-zA-Z-\s0-9]+\z/ }
  validate :stations_count
    
  before_validation :set_name

  private
    def stations_count
      errors.add(:base, :bad_stations) if railway_stations.size < 2
    end
    
    def set_name
      if self.name.blank? && railway_stations.any?
        if railway_stations.size >= 2
          self.name = "#{railway_stations.first.title} - #{railway_stations.last.title}" 
        end
      end
    end
end
