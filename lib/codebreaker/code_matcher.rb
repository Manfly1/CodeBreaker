# frozen_string_literal: true

module Codebreaker
  class CodeMatcher
    EXACT = '+'
    NON_EXACT = '-'

    attr_reader :guess, :code

    def secret_code(code, guess)
      @code = code.split('')
      @guess = guess.split('')
      handle_matched_digits.join + handle_matched_digits_with_wrong_position.join
    end

    private

    def handle_matched_digits
      code.map.with_index do |_, index|
        next unless code[index] == guess[index]

        @guess[index], @code[index] = nil
        EXACT
      end
    end

    def handle_matched_digits_with_wrong_position
      guess.compact.map do |number|
        next unless @code.include?(number)

        @code.delete_at(code.index(number))
        NON_EXACT
      end
    end
  end
end
