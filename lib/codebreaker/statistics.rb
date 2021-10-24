# frozen_string_literal: true

module Codebraker
  module Statistics
    include Storage

    def show_stats
      load_file.sort_by! { |game| [game[:available_attempts], game[:used_hints], game[:used_attempts]] }
    end
  end
end