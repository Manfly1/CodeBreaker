# frozen_string_literal: true

require_relative 'bootstrap'

module Codebreaker
  class User
    
    include Constants

    attr_accessor :attempts, :hints
    attr_reader :name

    GAME_ATTEMPTS = 0
    GAME_HINTS = 0

    def initialize(name: '', attempts: GAME_ATTEMPTS, hints: GAME_HINTS)
      @name = name
      @attempts = attempts
      @hints = hints
    end

    def name=(name)
      validate_name(name)
      @name = name
    end
  end
end
