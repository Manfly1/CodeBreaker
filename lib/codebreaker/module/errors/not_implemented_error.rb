# frozen_string_literal: true

class NotImplementedError < StandardError
  def message
    'Can not be less than 1'
  end
end
