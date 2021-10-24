# frozen_string_literal: true

require_relative 'storage'

module Codebreaker
  module Statistics
    include Storage

    def show_statistics
      load_file.sort_by! { |game| [game[:available_attempts], game[:used_hints], game[:used_attempts]] }
    end
  end
end
