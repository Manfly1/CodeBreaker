# frozen_string_literal: true

module Codebreaker
  class UserStatistic < Entity
    include Validation
    attr_reader :user, :difficulty, :attempts, :hints

    def initialize(user:, difficulty:, attempts:, hints:)
      super()
      @user = user
      @difficulty = difficulty
      @attempts = attempts
      @hints = hints
    end

    private

    def validate
      raise ClassValidError unless valid_class?(User, user)
      raise ClassValidError unless valid_class?(Difficulty, difficulty)

      validate_attempts
      validate_hints
    end

    def validate_attempts
      return raise ClassValidError unless valid_class?(Integer, attempts)

      raise NegativeIntegerError unless valid_non_negative_integer?(attempts)
    end

    def validate_hints
      return raise ClassValidError unless valid_class?(Integer, hints)

      raise NegativeIntegerError unless valid_non_negative_integer?(hints)
    end
  end
end
