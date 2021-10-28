# frozen_string_literal: true

require_relative 'bootstrap'

module Codebreaker
  class User < Entity
    attr_reader :name

    NAME_MIN_LENGTH = 3
    NAME_MAX_LENGTH = 20

    def initialize(name)
      super()
      @name = name
    end

    private

    def validate
      return raise ClassValidError unless valid_class?(String, name)

      raise MinLengthError unless valid_string_min_length?(name, NAME_MIN_LENGTH)
      raise MaxLengthError unless valid_string_max_length?(name, NAME_MAX_LENGTH)
    end
  end
end
