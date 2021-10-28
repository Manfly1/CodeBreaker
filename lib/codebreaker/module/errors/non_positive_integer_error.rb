# frozen_string_literal: true

class NonPositiveIntegerError < StandardError
  def initialize(message = 'Can not be less than 1')
    super(message)
  end
end
