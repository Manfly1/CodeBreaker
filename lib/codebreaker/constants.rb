# frozen_string_literal: true

module Codebreaker
  module Constants
    DIFFICULTIES = {
      easy: { attempts: 15, hints: 2 },
      medium: { attempts: 10, hints: 1 },
      hell: { attempts: 5, hints: 1 }
    }.freeze
    CODE_LENGTH = 4
    CODE_RANGE = (1..6).freeze
    EXACT = '+'
    NON_EXACT = '-'
    NAME_LENGTH = (3..20).freeze
  end
end
