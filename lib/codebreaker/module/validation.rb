# frozen_string_literal: true

require_relative 'errors/input_error'
require_relative 'errors/length_error'
require_relative 'errors/phase_error'

module Codebreaker
  module Validation
    def validate_name(name)
      raise LengthError unless Codebreaker::NAME_LENGTH.cover?(name.length)
    end

    def validate_guess(code)
      raise InputError unless Codebreaker::CODE_RANGE.match?(code)
    end
  end
end
