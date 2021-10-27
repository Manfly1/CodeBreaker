# frozen_string_literal: true

class DifficultyError < StandardError
  def initialize(message = 'Unknown difficulty!')
    super(message)
  end
end
