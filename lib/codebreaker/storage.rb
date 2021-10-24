# frozen_string_literal: true

require 'pry'

module Codebraker
  module Storage
    FILE_DIRECTORY = 'stats'
    FILE_NAME = 'stats.yml'

    def save_file(game)
      raise WrongStageError unless game.stage == Settings::WIN

      create_directory
      rating = load_file
      rating << game_data(game)
      store = YAML::Store.new(storage_path)
      store.transaction do
        store[:codebrakers] = rating
      end
      store
    end

    def load_file
      YAML.load_file(storage_path)[:codebrakers] || []
    rescue Errno::ENOENT
      []
    end

    def storage_path
      File.join(FILE_DIRECTORY, FILE_NAME)
    end

    private

    def fetch_user_data(game)
      user_data = {}
      user_data[:name] = game.user.name
      user_data[:used_attempts] = game.user.attempts
      user_data[:used_hints] = game.user.hints
      user_data
    end

    def create_directory
      Dir.mkdir(FILE_DIRECTORY) unless Dir.exist?(FILE_DIRECTORY)
      File.open(FILE_NAME, 'w') unless File.exist?(FILE_NAME)
    end

    def game_data(game)
      game_results = {}
      game_results[:difficulty] = game.difficulty
      game_results[:available_attempts] = Settings::DIFFICULTIES[game.difficulty][:attempts]
      game_results[:available_hints] = Settings::DIFFICULTIES[game.difficulty][:hints]
      game_results.merge(fetch_user_data(game))
    end
  end
end
