# frozen_string_literal: true

require 'yaml/store'
require 'date'

require_relative 'codebreaker/module/validation'
require_relative 'codebreaker/game_maker'
require_relative 'codebreaker/user'
require_relative 'codebreaker/constants'
require_relative 'codebreaker/statistics'
require_relative 'codebreaker/storage'
require_relative 'codebreaker/version'

  class Game
    include Validation
    include GameMaker
    include Constants
    include Storage

    attr_reader :phase, :hints, :code, :user, :difficulty, :date

    CODE_LENGTH = 4
    RANGE_GUESS_CODE = (1..6).freeze

    def initialize(difficulty: DIFFICULTIES, user:, code:, phase: START_GAME,  date: Date.today)
      @difficulty = difficulty
      @user = user
      @code = code
      @phase = phase
      @date = date
    end

    def start_new_game
      raise WrongPhaseError unless @phase == START_GAME

      @code = CODE_RANGE.sample(CODE_LENGTH).join
      @hints = @code.dup
      @phase = GAME
    end

    def guess(user_guess)
      raise WrongPhaseError unless @phase == GAME

      guess = user_guess.each_char.map(&:to_i)
      validate_guess(guess, CODE_LENGTH, RANGE_GUESS_CODE)

      check_guess(guess, secret_code)
      user.attempts -= ATTEMPTS_DECREMENT
    end

    def show_hint
      return if @hints.empty?

      hint = @hints.chars.sample
      @hints.sub!(hint, '')
      user.hints -= HINTS_DECREMENT
      hint
    end

    def won?(result)
      result == @code
    end

    def lost?
      user.attempts.zero?
    end

    def save_game(game)
      save_file(game)
    end

    def attempts
      (user.attempts < DIFFICULTIES[@difficulty][:attempts]) && user.attempts.positive?
    end

    def check_for_difficulties
      DIFFICULTIES
    end

    def end_game(guess)
      raise WrongPhaseError unless @phase == GAME

      if win?(guess)
        @phase = WIN
      elsif lose?
        @phase = LOSE
      end
      @phase
    end

    def generate_random_code
      Array.new(CODE_LENGTH) { rand(RANGE_GUESS_CODE) }
    end

    def check_guess(guess, secret_code)
      gameload = Codebreaker::Gameload.new(guess, secret_code)
      @user_guess = gameload.match
      @clues = gameload.clues
    end

    def increase_attempts(input_value)
        input_value, code, extra_char = check_position(input_value)
        _input_value, code, _extra_char = check_inclusion(input_value, code, extra_char)
        code
    end
  end
