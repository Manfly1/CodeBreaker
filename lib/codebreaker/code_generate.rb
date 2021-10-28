# frozen_string_literal: true

module Codebreaker
  class CodeGenerator < Entity
    CODE_RANGE = (1..6).freeze
    CODE_LENGTH = 4

    def initialize(range: CODE_RANGE, amount: CODE_LENGTH)
      super()
      @range = range
      @amount = amount
    end

    def generate
      Array.new(@amount) { rand(@range) }
    end

    private

    def validate
      raise ClassValidError unless valid_class?(Range, @range)
      raise ClassValidError unless valid_class?(Integer, @amount)

      raise NonPositiveIntegerError unless valid_positive_integer?(@amount)
    end
  end
end
