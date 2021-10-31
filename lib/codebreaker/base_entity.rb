# frozen_string_literal: true

module Codebreaker
  class BaseEntity
    def initialize(*)
      validate
    end

    private

    def validate; end
  end
end
