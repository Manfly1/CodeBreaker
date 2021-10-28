# frozen_string_literal: true

class MinLengthError < StandardError
  def initialize(message = 'Is too short ')
    super(message)
  end
end
