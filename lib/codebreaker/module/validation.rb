# frozen_string_literal: true

module Codebraker
  module Validation
    def validate_name(name)
      raise LengthError unless NAME_LENGTH.cover?(name.length)
    end

    def validate_guess(code)
      raise InputError unless RANGE_GUESS_CODE.match?(code)
    end
  end
end
