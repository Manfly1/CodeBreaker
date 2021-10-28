# frozen_string_literal: true

class NonNumericStringError < StandardError
  def initialize(message = 'Can contain only digits')
    super(message)
  end
end
