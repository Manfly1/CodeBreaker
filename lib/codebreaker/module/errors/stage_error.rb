# frozen_string_literal: true

class WrongStageError < StandardError
  def message
    'Incorrect stage of the game'
  end
end
