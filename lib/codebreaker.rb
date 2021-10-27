# frozen_string_literal: true

require_relative 'codebreaker/bootstrap'

class Game
  include Codebreaker::Validation
  include Codebreaker::Storage

    CODE_LENGTH = 4
    CODE_RANGE = (1..6).freeze

  attr_reader :secret_code, :hints, :hint_number, :attempts, :user, :result, :difficulty

  def initialize(user, difficulty)
    @user = user
    @difficulty = difficulty
    @attempts = difficulty.attempts
    @hints = difficulty.hints
    @secret_code = generate_secret_code
    @hint_number = @secret_code.clone
  end

  def guess(answer)
    @attempts -= 1
    @result = Codebreaker::DataMatcher.new(answer, @secret_code).check_guess
    @result
  end

  def hint
    raise HintError if @hints.zero?

    @hints -= 1
    random_index = rand(@hint_number.size)
    number = @hint_number[random_index]
    @hint_number.delete_at(random_index)
    number
  end

  private

  def generate_secret_code
    Array.new(Codebreaker::Constants::CODE_LENGTH) { rand(Codebreaker::Constants::CODE_RANGE) }
  end
end
