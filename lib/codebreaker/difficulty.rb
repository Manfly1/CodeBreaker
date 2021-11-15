# frozen_string_literal: true

module Codebreaker
  class Difficulty
    attr_reader :name, :attempts, :hints

    def initialize(name:, attempts:, hints:)
      @name = name
      @attempts = attempts
      @hints = hints
    end

    def <=>(other)
      [attempts, hints] <=> [other.attempts, other.hints]
    end
  end
end
