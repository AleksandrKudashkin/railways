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
    self.attributes.delete_if { |k, v| EXCLUDED_ATTR.include?(k) }
  end

  def allowed_list
    seats_list
  end
end

class SuburbanCoach < Coach
  SEATS = %w(simple_seats)
  SEATS.each { |seat| validates seat, presence: true, numericality: { only_integer: true } }
  validates :top_seats, :bottom_seats, :side_top_seats, :side_bottom_seats, absence: true
  
  def allowed_list
    Hash[SEATS.collect { |item| [item, ""] }]
  end
end

class EconomyCoach < Coach
  SEATS = %w(top_seats bottom_seats side_top_seats side_bottom_seat)
  SEATS.each { |seat| validates seat, presence: true, numericality: { only_integer: true } }
  validates :simple_seats, absence: true

  def allowed_list
    Hash[SEATS.collect { |item| [item, ""] }]
  end
end

class CompartmentCoach < Coach
  SEATS = %w(top_seats bottom_seats)
  SEATS.each { |seat| validates seat, presence: true, numericality: { only_integer: true } }
  validates :simple_seats, :side_top_seats, :side_bottom_seats, absence: true

  def allowed_list
    Hash[SEATS.collect { |item| [item, ""] }]
  end
end

class SleepingCoach < Coach
  SEATS = %w(bottom_seats)  
  SEATS.each { |seat| validates seat, presence: true, numericality: { only_integer: true } }
  validates :top_seats, :simple_seats, :side_top_seats, :side_bottom_seats, absence: true

  def allowed_list
    Hash[SEATS.collect { |item| [item, ""] }]
  end
end
