class SuburbanCoach < Coach
  validates :simple_seats, presence: true, numericality: { only_integer: true }
end
