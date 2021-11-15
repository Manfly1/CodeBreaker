# frozen_string_literal: true

module Codebreaker
  class CodeMatcher
    EXACT = '+'
    NON_EXACT = '-'

    attr_reader :guess, :secret_code

    def match(secret_code, guess)
      @secret_code = secret_code.split('')
      @guess = guess.split('')
      handle_matched_digits.join + handle_matched_digits_with_wrong_position.join
    end

    private

    def handle_matched_digits
      secret_code.map.with_index do |_, index|
        next unless secret_code[index] == guess[index]

        @guess[index], @secret_code[index] = nil
        EXACT
      end
    end

    def handle_matched_digits_with_wrong_position
      guess.compact.map do |number|
        next unless @secret_code.include?(number)

        @secret_code.delete_at(secret_code.index(number))
        NON_EXACT
      end
    end
  end
end
