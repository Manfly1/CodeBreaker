# frozen_string_literal: true

class RangeError < StandardError
  def initialize(message = 'Invalid range!')
    super(message)
  end
end
