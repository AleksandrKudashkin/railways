class RailwayStation < ActiveRecord::Base
  validates :title, presence: true
  has_and_belongs_to_many :routes
  has_many :trains
end
