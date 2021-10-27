# frozen_string_literal: true

require_relative 'bootstrap'

module Codebreaker
  class User
    include Constants
    include Validation

    attr_reader :name, :difficulty

    def initialize(difficulty = DIFFICULTIES)
      @name = name
      @difficulty = difficulty
      validate_name(name)
    end

    def generate_signs(input_value)
      raise WrongPhaseError unless @phase == IN_GAME_STATUS
  
      user.attempts -= ATTEMPTS_DECREMENT
      attempt(input_value)
    end

    def attempts?
      (user.attempts < DIFFICULTIES[@difficulty][:attempts]) && user.attempts.positive?
    end
  end
end
