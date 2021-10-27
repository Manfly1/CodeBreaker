# frozen_string_literal: true

require 'pry'

module Codebreaker
  module Storage
    FILE_DIRECTORY = 'statistics'
    FILE_NAME = 'statistics.yml'

    attr_accessor :data

    def initialize
      @data = db_initialized? ? load : initialize_db
    end

    def save
      store = YAML::Store.new(storage_path)
      store.transaction { @data.each { |key, value| store[key] = value } }
    end

    private

    def db_initialized?
      Dir.exist?(FILE_DIRECTORY) && File.file?(File.join(FILE_DIRECTORY, FILE_NAME))
    end

    def initialize_db
      Dir.mkdir(FILE_DIRECTORY)

      store = YAML::Store.new(File.join(FILE_DIRECTORY, FILE_NAME))
      store.transaction { default_data.each { |key, value| store[key] = value } }

      default_data
    end

    def storage_path
      File.join(FILE_DIRECTORY, FILE_NAME)
    end

    def load
      store = YAML::Store.new(storage_path)
      store.transaction { store.roots.to_h { |key| [key, store[key]] } }
    end
  end
end
