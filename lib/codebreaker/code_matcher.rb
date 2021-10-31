# frozen_string_literal: true

module Codebreaker
  class CodeMatcher
    attr_reader :answer

    EXACT = '+'
    NON_EXACT = '-'

    def initialize(secret_code, guess_code)
      @secret_code = secret_code
      @guess_code = guess_code
    end

    def match_codes
      secret_code = @secret_code.clone
      guess_code = @guess_code.clone

      strong_match(secret_code, guess_code) + soft_match(secret_code, guess_code)
    end

    def codes_match?
      @secret_code == @guess_code
    end

    private

    def strong_match(secret_code, guess_code)
      guess_answer = ''

      guess_code.count.times do |index|
        next unless secret_code[index] == guess_code[index]

        guess_answer += EXACT
        secret_code[index] = nil
        guess_code[index] = nil
      end

      guess_answer
    end

    def soft_match(secret_code, guess_code)
      guess_answer = ''

      guess_code.count.times do |index|
        next unless guess_code[index] && secret_code.include?(guess_code[index])

        guess_answer += NON_EXACT
        secret_code.delete_at(secret_code.index(guess_code[index]))
        guess_code[index] = nil
      end

      guess_answer
    end

    def validate
      raise ClassValidError unless valid_class?(Array, @secret_code)
      raise ClassValidError unless valid_class?(Array, @guess_code)
    end
  end
end
