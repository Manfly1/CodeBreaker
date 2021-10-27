# frozen_string_literal: true

class LengthError < StandardError
  def initialize(message = 'Argument length is not correct. ')
    super(message)
  end
end
