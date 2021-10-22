# frozen_string_literal: true

class LengthError < StandardError
  def message
    'Incorrect length'
  end
end
