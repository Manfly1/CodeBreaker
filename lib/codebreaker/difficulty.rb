# frozen_string_literal: true

module Codebreaker
  class Difficulty
    extend Validation
  
    DIFFICULTIES = {
      easy: { attempts: 15, hints: 2 },
      medium: { attempts: 10, hints: 1 },
      hell: { attempts: 5, hints: 1 }
    }.freeze

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
