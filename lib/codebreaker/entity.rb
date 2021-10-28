# frozen_string_literal: true

module Codebreaker
  class Entity
    include Validation

    attr_reader :errors

    def initialize
      @errors = {}
    end

    def valid?
      validate
      errors.empty?
    end

    private

    def validate; end
  end
end
