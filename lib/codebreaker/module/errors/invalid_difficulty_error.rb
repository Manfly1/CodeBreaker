# frozen_string_literal: true

class InvalidDifficultyError < StandardError
  def message
    'Invalid difficulty'
  end
end
