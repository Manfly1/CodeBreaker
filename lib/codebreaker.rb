# frozen_string_literal: true

require_relative 'codebreaker/bootstrap'

class Game
  attr_reader :difficulty, :user, :attempts_amount, :hints_amount, :code

  STATUS_IN_PROGRESS = :in_progress
  STATUS_WIN = :win
  STATUS_LOSE = :lose

  def initialize
    init_store unless storage_exist?
    load
    @secret_code = CodeGenerator.generate
    @status = STATUS_IN_PROGRESS
    @hints = @secret_code.sample(@secret_code.length)
  end

  def create_user(name, _difficulty)
    @user = Codebreaker::Difficulty.new(name, attempts, hints)
  end

  def create_difficulty(difficulty_name)
    @difficulty = Codebreaker::DifficultyFactory.generate(difficulty_name)
  end

  def win?
    @status == STATUS_WIN
  end

  def lose?
    @status == STATUS_LOSE
  end

  def take_hint
    return unless @user.hints?

    @user.hint
    @hints.pop
  end

  def take_attempt(_user_number)
    return equal if @user.attempts?

    matcher = CodeMatcher.new(secret_code, guess_code)
    matcher.match_codes
    @status = STATUS_LOSE
    nil
  end

  private

  def equal(_user_number)
    @user.attempt
    return unless @user.hints?
  end
end
