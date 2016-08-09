class Coach < ActiveRecord::Base
  belongs_to :train
  NO_ATTR = ["id","type","train_id", "created_at", "updated_at"]
  
  def just_seats
    @stash = self.attributes 
    NO_ATTR.each { |a| @stash.delete(a) }
    @stash
  end
end

class Suburban < Coach
  validates :simple_seats, presence: true, numericality: { only_integer: true }
  validates :top_seats, :bottom_seats, :side_top_seats, :side_bottom_seats, absence: true
end

class Economy < Coach
  validates :top_seats, :bottom_seats, :side_top_seats, :side_bottom_seats, presence: true, numericality: { only_integer: true }
  validates :simple_seats, absence: true
end

class Compartment < Coach
  validates :top_seats, :bottom_seats, presence: true, numericality: { only_integer: true }
  validates :simple_seats, :side_top_seats, :side_bottom_seats, absence: true
end

class Sleeping < Coach
  validates :bottom_seats, presence: true, numericality: { only_integer: true }
  validates :top_seats, :simple_seats, :side_top_seats, :side_bottom_seats, absence: true
end
