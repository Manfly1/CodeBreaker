# frozen_string_literal: true

require_relative 'bootstrap'

module Codebreaker
  class User
    include Constants
    extend Validation

    attr_accessor :name

    def initialize(name)
      @name = name
    end

    def self.validate(name)
      validate_argument_type(name, String)
      validate_length(name, NAME_LENGTH)
    end
  end
end
