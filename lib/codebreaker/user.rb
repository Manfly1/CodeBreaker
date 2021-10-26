# frozen_string_literal: true

require_relative 'bootstrap'

module Codebreaker
  class User
    include Constants
    include Validation

    attr_accessor :attempts, :hints
    attr_reader :name

    GAME_ATTEMPTS = 0
    GAME_HINTS = 0

    def initialize(name: :name, attempts: GAME_ATTEMPTS, hints: GAME_HINTS)
      @name = name
      @attempts = attempts
      @hints = hints
      validate_name(name)
    end
  end
end
