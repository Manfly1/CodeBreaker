# frozen_string_literal: true

module Codebreaker
  module Constants
    GAME_ATTEMPTS = 0
    GAME_HINTS = 0
    HINTS_DECREMENT = 1
    ATTEMPTS_DECREMENT = 1
    START_GAME = :start
    GAME = :game
    WIN = :win
    LOSE = :lose
    DIFFICULTIES = {
      easy: { attempts: 15, hints: 2 },
      medium: { attempts: 10, hints: 1 },
      hell: { attempts: 5, hints: 1 }
    }.freeze
    CODE_LENGTH = 4
    RANGE_GUESS_CODE = (1..6).to_a.freeze
    EXACT = '+'
    NONEXACT = '-'
    CODE_NUMBERS = /^[1-6]{4}$/.freeze
    NAME_LENGTH = (3..20).freeze
  end
end
