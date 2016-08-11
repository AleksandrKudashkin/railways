class Train < ActiveRecord::Base
  validates :number, presence: true, format: { with: /\A[0-9]{3}[-]*[0-9]{2}\z/, message: 'should be in format YYY-ZZ or YYYZZ' }
  belongs_to :route
  belongs_to :current_station, class_name: 'RailwayStation', foreign_key: :current_station_id
  has_many :tickets
  has_many :coaches

  delegate :compartment_coaches, :economy_coaches, :sleeping_coaches, :suburban_coaches, to: :coaches

  after_validation :name_to_format

  def seats_summary(coach_type, seats_type)
    Train.where(id: self.id).joins(:coaches).where('coaches.type = ?', coach_type).sum(seats_type)
  end

  private
    def name_to_format
      self.number.insert(3, '-') unless self.number.index('-')
    end
end
