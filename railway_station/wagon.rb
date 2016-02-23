class Wagon
  attr_reader :type
  include Manufacturer
  include Validator

  def initialize(wagon_size)
    @type = self.class
  end

  protected
    attr_writer :type
end

class PassangerWagon < Wagon
  attr_reader :max_capacity
  
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
    self.places_remains
  end

  def places_taken
    self.max_capacity - self.places_remains
  end

  protected
    attr_writer :max_capacity
    attr_accessor :places_remains

    def validate!
      raise "Wagon capacity must be a plus digit!" unless self.max_capacity.to_i > 0
    end
end

class CargoWagon < Wagon
  attr_reader :max_space

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
    self.max_space - self.space_remains
  end

  protected
    attr_writer :max_space
    attr_accessor :space_remains

    def validate!
      raise "Wagon space must be a plus digit!" unless self.max_space.to_i > 0
    end
end