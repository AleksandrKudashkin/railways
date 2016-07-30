# encoding: utf-8
# frozen_string_literal: true
class Wagon
  attr_reader :type
  include Manufacturer
  include Validation

  def initialize(_wagon_size)
    @type = self.class
  end

  protected

  attr_writer :type
end

class PassangerWagon < Wagon
  attr_reader :max_capacity
  validate :max_capacity, :presence
  validate :max_capacity, :format, /^[1-9]{1,}[0-9]{0,}$/i

  def initialize(capacity)
    super
    @max_capacity = capacity
    @places_remains = capacity
    validate!
  end

  def take_place
    result = self.places_remains -= 1
    raise "There is no free places in this wagon!" if result < 0
    result
  end

  def places_left
    places_remains
  end

  def places_taken
    max_capacity - places_remains
  end

  def to_s
    "type: #{type}, taken places: #{places_taken}, places left: #{places_left}"
  end

  protected

  attr_writer :max_capacity
  attr_accessor :places_remains

  def validate!
    raise "Wagon capacity must be a plus digit!" unless max_capacity.to_i > 0
  end
end

class CargoWagon < Wagon
  attr_reader :max_space
  validate :max_space, :presence
  validate :max_space, :format, /^[1-9]{1,}[0-9]{0,}$/i

  def initialize(space)
    super
    @max_space = space
    @space_remains = space
    validate!
  end

  def hold_space(space)
    result = self.space_remains -= space
    raise "There is no free space for you goods!" if result < 0
    result
  end

  def free_space
    self.space_remains
  end

  def taken_space
    max_space - space_remains
  end

  def to_s
    "type: #{type}, taken space: #{taken_space}, free space: #{free_space}"
  end

  protected

  attr_writer :max_space
  attr_accessor :space_remains

end
