# frozen_string_literal: true

module Codebreaker
  class Difficulty
    attr_reader :name, :attempts, :hints

    def initialize(name:, attempts:, hints:)
      @name = name
      @attempts = attempts
      @hints = hints
    end

    def <=>(other)
      [attempts, hints] <=> [other.attempts, other.hints]
    end

    private

    def validate
      validate_name
      validate_attempts
      validate_hints
    end

    def validate_name
      raise ClassValidError unless valid_class?(String, name)

      raise EmptyStringsError unless valid_non_empty_string?(name)
    end

    def validate_attempts
      raise ClassValidError unless valid_class?(Integer, attempts)

      raise NonPositiveIntegerError unless valid_positive_integer?(attempts)
    end

    def validate_hints
      raise ClassValidError unless valid_class?(Integer, hints)

      raise NonPositiveIntegerError unless valid_non_negative_integer?(hints)
    end
  end
end
