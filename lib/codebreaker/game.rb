# frozen_string_literal: true

module Codebreaker
  class Game
    include Validation

    attr_reader :clues, :user, :difficulty,
                :attempts_used, :hints_used, :very_secret_code,
                :date

    DIFFICULTIES = {
      easy: { attempts: 15, hints: 2 },
      medium: { attempts: 10, hints: 1 },
      hell: { attempts: 5, hints: 1 }
    }.freeze

    CODE_LENGTH = 4
    RANGE_GUESS_CODE = (1..6).freeze

    def initialize(difficulty:, user:, date: Date.today)
      validate_difficulty(difficulty, DIFFICULTIES)

      @user = user
      @difficulty = difficulty
      @date = date

      attempts
      number_of_hints
    end
