# frozen_string_literal: true

require_relative 'constants'

module Codebreaker
  class DataMatcher
    include Constants
    extend Validation

    attr_reader :guess, :secret_code, :result, :non_exact_answer, :exact_answer

    def initialize(guess, secret_code)
      @secret_code = secret_code
      @guess = break_number(guess)
    end

    def symbols(exact_answer = EXACT, non_exact_answer = NON_EXACT)
      @exact_answer = exact_answer
      @non_exact_answer = non_exact_answer
    end

    def check_guess
      symbols
      @result = @non_exact_answer * count_matched_numbers
      @guess.each_with_index do |element, index|
        @result.sub!(@non_exact_answer, @exact_answer) if element == @secret_code[index]
      end
      @result
    end

    def self.validate(guess)
      validate_length(guess, CODE_LENGTH)
    end

    private

    def count_matched_numbers
      (@secret_code & @guess).map { |element| [@secret_code.count(element), @guess.count(element)].min }.sum
    end

    def break_number(number)
      number.to_s.scan(/./).map(&:to_i)
    end
  end
end
