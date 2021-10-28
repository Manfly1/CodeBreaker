# frozen_string_literal: true

require_relative 'codebreaker/bootstrap'

class Game < Codebreaker::Entity
  attr_reader :difficulty, :user, :attempts_amount, :hints_amount, :code

  def initialize(difficulty, user)
    super()
    @difficulty = difficulty
    @user = user
  end

  def start
    prepare_game
  end

  def self.user_statistic
    store = Codebreaker::Storage.new
    store.data[:user_statistics].sort_by { |stats| [stats.difficulty, stats.attempts, stats.hints] }
  end

  def save_statistic
    store = Codebreaker::Storage.new
    store.data[:user_statistics] << current_statistic
    store.save
  end

  def take_hint
    @hints_amount -= 1
    @hints.pop
  end

  def make_turn(guess)
    @guess = guess
    @attempts_amount -= 1

    matcher = Codebreaker::CodeMatcher.new(code, guess.code)
    matcher.match_codes
  end

  def win?
    code == @guess&.code
  end

  def lose?
    attempts_amount < 1 && !win?
  end

  def restart
    prepare_game
  end

  private

  def current_statistic
    Codebreaker::User.new(user: user, difficulty: difficulty,
                          attempts: difficulty.attempts - attempts_amount,
                          hints: difficulty.hints - hints_amount)
  end

  def validate
    raise ClassValidError unless valid_class?(Codebreaker::User, user)
    raise ClassValidError unless valid_class?(Codebreaker::Difficulty, difficulty)
  end

  def prepare_game
    @attempts_amount = difficulty.attempts
    @hints_amount = difficulty.hints
    @code = Codebreaker::CodeGenerator.new.generate
    @hints = code.sample(hints_amount)
  end
end
