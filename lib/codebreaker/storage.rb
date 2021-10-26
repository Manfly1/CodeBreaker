# frozen_string_literal: true

require 'pry'

module Codebreaker
  module Storage
    FILE_DIRECTORY = 'statistics'
    FILE_NAME = 'statistics.yml'

    def save_file(game)
      raise WrongPhaseError unless game.phase == WIN_STATUS

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
      user_data[:attempts] = game.user.attempts
      user_data[:hints] = game.user.hints
      user_data
    end

    def create_directory
      Dir.mkdir(FILE_DIRECTORY) unless Dir.exist?(FILE_DIRECTORY)
      File.open(FILE_NAME, 'w') unless File.exist?(FILE_NAME)
    end

    def game_data(game)
      game_results = {}
      game_results[:difficulty] = game.difficulty
      game_results[:available_attempts] = Constants::DIFFICULTIES[game.difficulty][:attempts]
      game_results[:available_hints] = Constants::DIFFICULTIES[game.difficulty][:hints]
      game_results.merge(fetch_user_data(game))
    end
  end
end
