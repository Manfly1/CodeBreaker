# frozen_string_literal: true

require_relative 'codebreaker/bootstrap'

class Game
  include Codebreaker::Validation
  include Codebreaker::GameMaker
  include Codebreaker::Constants
  include Codebreaker::Storage

  attr_reader :phase, :hints, :code, :user, :difficulty

  START_STATUS = :start
  GAME_STATUS = :game
  WIN_STATUS = :win
  LOSE_STATUS = :lose
  HINTS_DECREMENT = 1
  ATTEMPTS_DECREMENT = 1

  def initialize(code: '', user: Codebreaker::User.new, phase: START_STATUS, difficulty: DIFFICULTIES)
    @code = code
    @user = user
    @phase = phase
    @difficulty = difficulty
  end

  def start_new_game
    raise WrongPhaseError unless @phase == START_STATUS

    @code = CODE_RANGE.sample(CODE_LENGTH).join
    @possible_hints = @code.dup
    @phase = GAME_STATUS
  end

  def generate_signs(input_value)
    raise WrongPhaseError unless @phase == GAME_STATUS

    user.attempts -= ATTEMPTS_DECREMENT
    display_signs(input_value)
  end

  def assign_difficulty(input)
    return unless DIFFICULTIES.include?(input.to_sym)

    user.attempts = DIFFICULTIES[input.to_sym][:attempts]
    user.hints = DIFFICULTIES[input.to_sym][:hints]
  end

  def show_hint
    return if @possible_hints.empty?

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

  def attempts?
    (user.attempts < DIFFICULTIES[@difficulty][:attempts]) && user.attempts.positive?
  end

  def check_for_difficulties
    DIFFICULTIES
  end

  def end_game(guess)
    raise WrongPhaseError unless @phase == GAME_STATUS

    if win?(guess)
      @phase = WIN_STATUS
    elsif lose?
      @phase = LOSE_STATUS
    end
    @phase
  end

  def display_signs(input_value)
    input_value, code, extra_char = check_position(input_value)
    _input_value, code, _extra_char = check_inclusion(input_value, code, extra_char)
    code
  end
end
