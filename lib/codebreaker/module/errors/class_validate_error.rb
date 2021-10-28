# frozen_string_literal: true

class ClassValidError < StandardError
  def initialize(message = 'Unexpected type')
    super(message)
  end
end
