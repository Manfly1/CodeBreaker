# frozen_string_literal: true

module Codebreaker
  class Difficulty < Entity
    attr_reader :name, :attempts, :hints

    EASY = :easy
    MEDIUM = :medium
    HELL = :hell

    def initialize(name:, attempts:, hints:)
      super()
      @name = name
      @attempts = attempts
      @hints = hints
    end

    def <=>(other)
      [attempts, hints] <=> [other.attempts, other.hints]
    end

    def self.difficulties(keyword)
      case keyword
      when EASY then Difficulty.new(name: 'Easy', attempts: 15, hints: 2)
      when MEDIUM then Difficulty.new(name: 'Medium', attempts: 10, hints: 1)
      when HELL then Difficulty.new(name: 'Hell', attempts: 5, hints: 1)
      end
    end

    private

    def validate
      validate_name
      validate_attempts
      validate_hints
    end

    def validate_name
      return raise ClassValidError unless valid_class?(String, name)

      raise EmptyStringsError unless valid_non_empty_string?(name)
    end

    def validate_attempts
      return raise ClassValidError unless valid_class?(Integer, attempts)

      raise NonPositiveIntegerError unless valid_positive_integer?(attempts)
    end

    def validate_hints
      return raise ClassValidError unless valid_class?(Integer, hints)

      raise NonPositiveIntegerError unless valid_non_negative_integer?(hints)
    end
  end
end
