class Train < ActiveRecord::Base
  validates :number, presence: true, format: { with: /\A[0-9]{3}[-]*[0-9]{2}\z/, message: 'should be in format YYY-ZZ or YYYZZ' }
  belongs_to :route
  belongs_to :current_station, class_name: 'RailwayStation', foreign_key: :current_station_id
  has_many :tickets
  has_many :coaches

  after_validation :name_to_format

  private
    def name_to_format
      self.number.insert(3, '-') unless self.number.index('-')
    end
end
