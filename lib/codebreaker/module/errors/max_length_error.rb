# frozen_string_literal: true

class MaxLengthError < StandardError
  def initialize(message = 'Is too long')
    super(message)
  end
end
