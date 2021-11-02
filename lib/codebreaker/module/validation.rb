# frozen_string_literal: true

require_relative 'errors/range_error'
require_relative 'errors/non_numeric_string_error'
require_relative 'errors/non_positive_integer_error'
require_relative 'errors/empty_strings_error'
require_relative 'errors/class_validate_error'
require_relative 'errors/min_length_error'
require_relative 'errors/max_length_error'
require_relative 'errors/negative_integer_error'
require_relative 'errors/invalid_difficulty_error'

module Codebreaker
  module Validation
    def valid_class?(expected_class, instance)
      instance.is_a?(expected_class)
    end

    def valid_non_empty_string?(string)
      !string.empty?
    end

    def valid_positive_integer?(number)
      number.positive?
    end

    def valid_non_negative_integer?(number)
      !number.negative?
    end

    def valid_string_min_length?(string, min_length)
      string.length <= min_length
    end

    def valid_string_max_length?(string, max_length)
      string.length >= max_length
    end

    def valid_only_numeric_string?(string)
      /\A\d+\Z/.match?(string)
    end

    def valid_range?(range, code)
      code.each { |digit| return false unless range.cover?(digit) }
      true
    end
  end
end
