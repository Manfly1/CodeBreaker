# frozen_string_literal: true

module Codebreaker
  class DifficultyFactory
    DIFFICULTIES = {

      easy: {
        name: 'easy',
        attempts: 15,
        hints: 2
      },
      medium: {
        name: 'medium',
        attempts: 10,
        hints: 1
      },
      hell: {
        name: 'hell',
        attempts: 5,
        hints: 1
      }

    }.freeze
    def self.generate(difficulty_name)
      case difficulty_name
      when DIFFICULTIES[:easy] then Difficulty.new(DIFFICULTIES[:easy])
      when DIFFICULTIES[:medium] then Difficulty.new(DIFFICULTIES[:medium])
      when DIFFICULTIES[:hell] then Difficulty.new(DIFFICULTIES[:hell])
      else raise Errors::InvalidDifficultyError
      end
    end
  end
end
