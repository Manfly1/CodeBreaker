# frozen_string_literal: true

module Codebreaker
  class CodeGenerator < BaseEntity
    CODE_RANGE = (1..6).freeze
    CODE_LENGTH = 4

    def self.generate(length = CODE_LENGTH)
      Array.new(length) { rand(CODE_RANGE) }
    end
  end
end
