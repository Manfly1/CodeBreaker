# frozen_string_literal: true

module Codebreaker
  class Difficulty
    extend Validation
    include Constants

    attr_reader :difficulty

    def initialize(difficulty)
      @difficulty = difficulty.to_sym
    end

    def attempts
      DIFFICULTIES[@difficulty][:attempts]
    end

    def hints
      DIFFICULTIES[@difficulty][:hints]
    end

    def self.validate(difficulty)
      validate_difficulty_name(difficulty, DIFFICULTIES)
    end
  end
end
