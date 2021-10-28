# frozen_string_literal: true

class EmptyStringsError < StandardError
  def initialize(message = 'This strings is empty! ')
    super(message)
  end
end
