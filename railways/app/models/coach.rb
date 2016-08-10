class Coach < ActiveRecord::Base
  belongs_to :train
  
  EXCLUDED_ATTR = %w(id type train_id created_at updated_at)
  SUBCLASS_LIST = %w(CompartmentCoach EconomyCoach SleepingCoach SuburbanCoach)
  
  validates :type, presence: true, inclusion: { in: SUBCLASS_LIST,
        message: "%{value} is not a valid coach type" }

  scope :compartment_coaches, -> { where(type: 'CompartmentCoach') } 
  scope :economy_coaches, -> { where(type: 'EconomyCoach') } 
  scope :sleeping_coaches, -> { where(type: 'SleepingCoach') }
  scope :suburban_coaches, -> { where(type: 'SuburbanCoach') }

  def self.types
    SUBCLASS_LIST 
  end

  def seats_list
    @stash = self.attributes 
    EXCLUDED_ATTR.each { |a| @stash.delete(a) }
    @stash
  end
end

class SuburbanCoach < Coach
  validates :simple_seats, presence: true, numericality: { only_integer: true }
  validates :top_seats, :bottom_seats, :side_top_seats, :side_bottom_seats, absence: true
end

class EconomyCoach < Coach
  validates :top_seats, :bottom_seats, :side_top_seats, :side_bottom_seats, presence: true, numericality: { only_integer: true }
  validates :simple_seats, absence: true
end

class CompartmentCoach < Coach
  validates :top_seats, :bottom_seats, presence: true, numericality: { only_integer: true }
  validates :simple_seats, :side_top_seats, :side_bottom_seats, absence: true
end

class SleepingCoach < Coach
  validates :bottom_seats, presence: true, numericality: { only_integer: true }
  validates :top_seats, :simple_seats, :side_top_seats, :side_bottom_seats, absence: true
end
