# frozen_string_literal: true

module Codebreaker
  class Guess < Entity
    CODE_LENGTH = 4

    def initialize(string_code)
      super()
      @string_code = string_code
    end

    def code
      @code ||= parse_code
    end

    private

    def parse_code
      @string_code.chars.map { |number| Integer(number) }
    end

    def validate
      return raise ClassValidError unless valid_class?(String, @string_code)

      validate_code_length
      return raise NonNumericStringError unless valid_only_numeric_string?(@string_code)

      raise RangeError unless valid_range?(CodeGenerator::CODE_RANGE, parse_code)
    end

    def validate_code_length
      raise MinLengthError unless valid_string_min_length?(@string_code, CODE_LENGTH)
      raise MaxLengthError unless valid_string_max_length?(@string_code, CODE_LENGTH)
    end
  end
end
