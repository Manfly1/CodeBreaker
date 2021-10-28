# frozen_string_literal: true

class NegativeIntegerError < StandardError
  def initialize(message = 'Can not be negative number')
    super(message)
  end
end
