class SameStationValidator < ActiveModel::Validator
  def validate(record)
    if record.first_station == record.last_station
      record.errors[:base] << "First and last stations cannot be the same stations"
    end
  end
end

class Ticket < ActiveRecord::Base
  validates :passenger_full_name, presence: true, length: { minimum: 5 }
  validates_with SameStationValidator
  belongs_to :train
  belongs_to :user
  belongs_to :first_station, class_name: 'RailwayStation', foreign_key: :first_station_id
  belongs_to :last_station, class_name: 'RailwayStation', foreign_key: :last_station_id
end
