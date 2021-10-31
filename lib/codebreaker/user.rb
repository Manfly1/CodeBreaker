# frozen_string_literal: true

require_relative 'bootstrap'

module Codebreaker
  class User
    attr_reader :name, :difficulty, :used_attempts, :used_hints

    NAME_MIN_LENGTH = 3
    NAME_MAX_LENGTH = 20

    def initialize(*)
      @name = name
      @difficulty = difficulty
      @used_attempts = 0
      @used_hints = 0
    end

    def hints?
      difficulty.hints = used_hints
    end

    def attempts?
      difficulty.attempts = used_attempts
    end

    def hint
      @used_hints += 1
    end

    def attempt
      @used_attempts += 1
    end

    private

    def validate
      raise ClassValidError unless valid_class?(String, name)
      raise MinLengthError unless valid_string_min_length?(name, NAME_MIN_LENGTH)
      raise MaxLengthError unless valid_string_max_length?(name, NAME_MAX_LENGTH)
      raise ClassValidError unless valid_class?(Difficulty, difficulty)
    end
  end
end
