# frozen_string_literal: true

class InputError < StandardError
  def initialize
    'Incorrect input'
  end
end
