# frozen_string_literal: true

require 'yaml/store'
require 'date'

require_relative 'codebreaker/module/validation'
require_relative 'codebreaker/gameload'
require_relative 'codebreaker/user'
require_relative 'codebreaker/file_loader'
require_relative 'codebreaker/module/file_loader'
require_relative 'codebreaker/version'

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

    def start_new_game
      @very_secret_code = generate_random_code
      @hints = @very_secret_code.clone
      @attempts_used = 0
      @hints_used = 0
      @user_guess = []
      @clues = []
    end

    def guess(user_guess)
      guess = user_guess.each_char.map(&:to_i)
      validate_guess(guess, CODE_LENGTH, RANGE_GUESS_CODE)
      check_guess(guess, very_secret_code)

      increase_attempts
    end

    def show_hint
      validate_hints(hints_used, number_of_hints)

      @hints_used += 1
      @hints.shuffle!.pop
    end

    def won?
      @user_guess.nil?
    end

    def lost?
      @attempts_used >= @attempts
    end

    def save_game
      FileLoader.new.save(self)
    end

    def attempts
      @attempts ||= DIFFICULTIES[difficulty.to_sym][:attempts]
    end

    def number_of_hints
      @number_of_hints ||= DIFFICULTIES[difficulty.to_sym][:hints]
    end

    private

    def generate_random_code
      Array.new(CODE_LENGTH) { rand(RANGE_GUESS_CODE) }
    end

    def check_guess(guess, secret_code)
      gameload = Codebreaker::Gameload.new(guess, secret_code)
      @user_guess = gameload.match
      @clues = gameload.clues
    end

    def increase_attempts
      @attempts_used += 1
    end
  end
end
