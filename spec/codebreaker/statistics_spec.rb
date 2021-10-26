# frozen_string_literal: true

RSpec.describe Codebreaker::Statistics do
  describe '#show_statistics' do
    let(:test_module) { Class.new { include Codebreaker::Storage }.new }
    let(:expected_values) do
      [
        { name: 'name_3', difficulty: :hell, available_attempts: 5, used_attempts: 4, available_hints: 1,
          used_hints: 1 },
        { name: 'name_2', difficulty: :medium, available_attempts: 10, used_attempts: 3, available_hints: 1,
          used_hints: 0 },
        { name: 'name', difficulty: :easy, available_attempts: 15, used_attempts: 4, available_hints: 2, used_hints: 1 }
      ]
    end

    before do
      stub_const('Codebreaker::Storage::FILE_NAME', 'test_data.yml')
      stub_const('Codebreaker::Storage::FILE_DIRECTORY', 'spec/fixtures')
      [['name', 4, 1, :easy], ['name_2', 3, 0, :medium],
       ['name_3', 4, 1, :hell]].each do |name, attempts, hints, difficulty|
        test_game = Game.new
        test_game.instance_variable_set(:@difficulty, difficulty)
        test_game.user.instance_variable_set(:@name, name)
        test_game.user.attempts = attempts
        test_game.user.hints = hints
        test_game.instance_variable_set(:@phase, Codebreaker::Constants::WIN_STATUS)
        test_module.save_file(test_game)
      end
    end

    after do
      File.delete(test_module.storage_path) if File.exist?(test_module.storage_path)
    end

    it 'returns stats' do
      expect(Class.new.extend(Codebreaker::Statistics).show_statistics.class).to eq(Array)
    end
  end
end
