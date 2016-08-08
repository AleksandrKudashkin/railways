class Coach < ActiveRecord::Base
  belongs_to :train
end

class Sleeping < Coach
  validates :bottom_seats, presence: true, numericality: { only_integer: true }
end

class Economy < Coach
  validates :top_seats, presence: true, numericality: { only_integer: true }
  validates :bottom_seats, presence: true, numericality: { only_integer: true }
  validates :side_top_seats, presence: true, numericality: { only_integer: true }
  validates :side_bottom_seats, presence: true, numericality: { only_integer: true }
end

class Compartment < Coach
  validates :top_seats, presence: true, numericality: { only_integer: true }
  validates :bottom_seats, presence: true, numericality: { only_integer: true }
end

class Suburban < Coach
  validates :simple_seats, presence: true, numericality: { only_integer: true }
end
