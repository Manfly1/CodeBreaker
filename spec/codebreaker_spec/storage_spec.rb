# frozen_string_literal: true

RSpec.describe Codebreaker::Storage do
  let(:test_class) { Class.new { include Codebreaker::Storage }.new }
  let(:user) { double(Codebreaker::User, name: 'User', hints: 2, attempts: 15) }
  let(:game) { double(Game, user: user, difficulty: :easy) }
  before do
    stub_const('Codebreaker::Storage::FILE_NAME', './store/statistics.yml')
  end

  describe '#store' do
    it 'returns true when file is empty' do
      expect(test_class.store).not_to eq(Codebreaker::Storage::FILE_NAME)
    end
  end

  describe '#load' do
    it 'returns true when file is empty' do
      expect(test_class.load).to eq nil
    end
  end

  describe '#save' do
    after do
      File.delete(Codebreaker::Storage::FILE_NAME) if File.exist?(Codebreaker::Storage::FILE_NAME)
    end

    it 'creates file, puts data inside and deletes file' do
      test_class.save
      expect(test_class.load).to eq(nil)
    end
  end
end
