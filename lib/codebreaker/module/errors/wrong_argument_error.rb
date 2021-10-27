# frozen_string_literal: true

class WrongArgumentError < StandardError
  def initialize(message = 'Wrong argument given!')
    super(message)
  end
end
