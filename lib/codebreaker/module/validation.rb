# frozen_string_literal: true

require_relative 'errors/input_error'
require_relative 'errors/length_error'
require_relative 'errors/difficulty_error'
require_relative 'errors/hints_error'
require_relative 'errors/wrong_argument_error'
require_relative 'errors/wrong_code_error'

module Codebreaker
  module Validation
    def validate_name(name)
      raise LengthError unless Codebreaker::NAME_LENGTH.cover?(name.length)
    end

    def validate_guess(code)
      raise InputError unless Codebreaker::CODE_RANGE.match?(code)
    end

    def validate_difficulty_name(difficulty_given, difficulties)
      raise DifficultyError until difficulties.key?(difficulty_given.to_sym)
    end

    def validate_length(argument, length_argument)
      raise LengthError until argument == length_argument
    end

    def validate_argument_type(argument, class_name)
      raise WrongArgumentError until argument.is_a?(class_name)
    end
  end
end
