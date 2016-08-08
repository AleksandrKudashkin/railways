class SleepingCoach < Coach
  validates :bottom_seats, presence: true, numericality: { only_integer: true }
end
