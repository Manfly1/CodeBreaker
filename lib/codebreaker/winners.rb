# frozen_string_literal: true

module Codebreaker
  class Winner
    attr_reader :user, :created_at

    def initialize(_user)
      @user = user
      @created_at = DateTime.now
    end
  end
end
