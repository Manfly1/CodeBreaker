# frozen_string_literal: true

require_relative 'codebreaker/bootstrap'

class Game
  include Codebreaker::Validation
  include Codebreaker::DataMatcher
  include Codebreaker::Constants
  include Codebreaker::Storage

  attr_reader :phase, :hints, :code, :user

  START_STATUS = :start
  IN_GAME_STATUS = :in_game
  WIN_STATUS = :win
  LOSE_STATUS = :lose
  HINTS_DECREMENT = 1
  ATTEMPTS_DECREMENT = 1

  def initialize()
    @code = code == ''
    @phase = phase == START_STATUS
    user
  end

  def user
    Codebreaker::User.new
  end

  def start_new_game
    raise WrongPhaseError unless @phase == START_STATUS

    @code = CODE_RANGE.sample(CODE_LENGTH).join
    @possible_hints = @code.dup
    @phase = IN_GAME_STATUS
  end

  def assign_difficulty(input)
    return unless DIFFICULTIES.include?(input.to_sym)

    user.attempts = DIFFICULTIES[input.to_sym][:attempts]
    user.hints = DIFFICULTIES[input.to_sym][:hints]
  end

  def show_hint
    hint = @possible_hints.chars.sample
    @possible_hints.sub!(hint, '')
    user.hints -= HINTS_DECREMENT
    hint
  end

  def win?(result)
    result == @code
  end

  def lose?
    user.attempts.zero?
  end

  def save_game(game)
    save_file(game)
  end

  def check_for_difficulties
    DIFFICULTIES
  end

  def end_game(guess)
    raise WrongPhaseError unless @phase == IN_GAME_STATUS

    if win?(guess)
      @phase = WIN_STATUS
    elsif lose?
      @phase = LOSE_STATUS
    end
    @phase
  end

  def attempt(input_value)
    input_value, code, extra_char = check_position(input_value)
    _input_value, code, _extra_char = check_inclusion(input_value, code, extra_char)
    code
  end
end
