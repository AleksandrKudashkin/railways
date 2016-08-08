class EconomyCoach < Coach
  validates :top_seats, presence: true, numericality: { only_integer: true }
  validates :bottom_seats, presence: true, numericality: { only_integer: true }
  validates :side_top_seats, presence: true, numericality: { only_integer: true }
  validates :side_bottom_seats, presence: true, numericality: { only_integer: true }
end
