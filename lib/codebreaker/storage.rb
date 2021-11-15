# frozen_string_literal: true

module Codebreaker
  module Storage
    FILE_NAME = './store/statistics.yml'

    def init_store
      save
    end

    def load
      store.transaction do
        @winners = store[:winners]
      end
    end

    def save
      store.transaction do
        store[:winners] = @winners
      end
    end

    def storage_exists?
      File.exist?(FILE_NAME)
    end

    def store
      @store ||= YAML::Store.new(FILE_NAME)
    end
  end
end
