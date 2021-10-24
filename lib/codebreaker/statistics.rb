# frozen_string_literal: true

require_relative 'bootstrap'

module Codebraker
  module Statistics
    include Storage

    def show_stats
      load_file.sort_by! { |game| [game[:available_attempts], game[:used_hints], game[:used_attempts]] }
    end
  end
end
