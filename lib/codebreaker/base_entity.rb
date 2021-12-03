# frozen_string_literal: true

module Codebreaker
  class BaseEntity
    include Validation
    def initialize(*)
      validate
    end

    def validate; end
  end
end
