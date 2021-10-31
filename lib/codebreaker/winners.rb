# frozen_string_literal: true

module Codebreaker
  class Winner < BaseEntity
    attr_reader :user, :created_at

    def initialize(user)
      @user = user
      @created_at = DateTime.now
      super
    end

    private

    def validate
      raise ClassValidError unless valid_class?(String, name)
    end
  end
end
