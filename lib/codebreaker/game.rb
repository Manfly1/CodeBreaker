# frozen_string_literal: true

module Codebreaker
  class Game
    include Validation

    attr_reader :clues, :user, :difficulty,
                :attempts_used, :hints_used, :very_secret_code,
                :date
  end
end
