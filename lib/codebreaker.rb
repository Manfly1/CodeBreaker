# frozen_string_literal: true

require_relative 'codebreaker/bootstrap'

class Game
  extend Codebreaker::Storage

  attr_reader :difficulty, :user, :attempts, :hints, :code

  STATUS_IN_PROGRESS = :in_progress
  STATUS_WIN = :win
  STATUS_LOSE = :lose

  def initialize(name, difficulty)
    @name = name
    @difficulty = difficulty
    @secret_code = Codebreaker::CodeGenerator.generate
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
    return unless @user.hints

    @user.hints
    @hints.pop
  end

  def take_attempt(code, guess)
    return equal if @user.attempts

    matcher = Codebreaker::CodeMatcher.new(code, guess)
    matcher.secret_code
    @status = STATUS_LOSE
    nil
  end

  private

  def equal(_guess)
    @user.attempt
    return unless @user.hints?
  end
end
