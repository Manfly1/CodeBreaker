# frozen_string_literal: true

require_relative 'codebreaker/bootstrap'

class Game
  extend Codebreaker::Storage

  attr_reader :user

  STATUS_IN_PROGRESS = :in_progress
  STATUS_WIN = :win
  STATUS_LOSE = :lose

  def initialize
    @secret_code = Codebreaker::CodeGenerator.generate
    @status = STATUS_IN_PROGRESS
    @hints = @secret_code.sample(@secret_code.length)
    @storage = Game.store
    save_storage unless Game.storage_exists?
  end

  def create_user(name, difficulty)
    @user = Codebreaker::User.new(name, difficulty)
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
    user.hint if user.hints?

    @hints.pop
  end

  def take_attempt(guess)
    return equal(@secret_code, guess.to_s) if user.attempts?

    @status = STATUS_LOSE
    nil
  end

  def save_storage
    @storage.transaction do
      @storage[:winners] = @winners || []
    end
  end

  private

  def win
    @winners << CodebreakerGame::Winner.new(user)
    @status = STATUS_WIN
  end

  def equal(_secret_code, guess)
    user.attempt
    Codebreaker::CodeMatcher.match(@secret_code, guess)
  end
end
