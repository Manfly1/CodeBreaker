# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  minimum_coverage 93
  add_filter 'spec'
  add_filter 'vendor'
end

require 'faker'
require 'bundler/setup'
require 'codebreaker'

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'

  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

RSpec::Matchers.define :be_a_directory do
  match do |dir_path|
    Dir.exist?(dir_path)
  end
end
