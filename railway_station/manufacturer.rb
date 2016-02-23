# encoding: utf-8
# frozen_string_literal: true
module Manufacturer
  attr_reader :manufacturer

  def manufacturer(who)
    self.manufacturer = who
  end

  private

  attr_writer :manufacturer
end
