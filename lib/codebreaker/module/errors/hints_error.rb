# frozen_string_literal: true

class HintError < StandardError
  def initialize(message = 'You used all hints!')
    super(message)
  end
end
