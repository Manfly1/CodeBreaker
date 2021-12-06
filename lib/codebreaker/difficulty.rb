# frozen_string_literal: true

module Codebreaker
  class Difficulty
    attr_reader :name, :attempts, :hints

    NEGATIVE_INTEGER = 0

    def initialize(name:, attempts:, hints:)
      @name = name
      @attempts = attempts
      @hints = hints
    end

    private

    def validate
      raise Errors::ClassValidError unless valid_class?(String, difficulty)
      raise Errors::NegativeIntegerError unless  valid_non_negative_integer?(attempts, NEGATIVE_INTEGER)
      raise Errors::NegativeIntegerError unless  valid_non_negative_integer?(hints, NEGATIVE_INTEGER)
    end
  end
end
