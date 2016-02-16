module Manufacturer
  attr_reader :manufacturer
  
  def set_manufacturer(who)
    self.manufacturer = who
  end

  private
    attr_writer :manufacturer
end