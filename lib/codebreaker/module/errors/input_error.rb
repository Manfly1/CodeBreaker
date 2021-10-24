# frozen_string_literal: true

class InputError < StandardError
  def initialize
    super 'Incorrect input'
  end
end
