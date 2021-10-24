# frozen_string_literal: true

class WrongPhaseError < StandardError
  def message
    'Incorrect phase of the game'
  end
end
