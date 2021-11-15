# frozen_string_literal: true

RSpec.describe Codebreaker::User do
  let(:game) { described_class.new }
  let(:difficulty) { Codebreaker::Difficulty.new(name: name, attempts: attempts, hints: hints) }
  let(:name) { :easy }
  let(:attempts) { 15 }
  let(:hints) { 2 }
  describe '#valid?' do
    let(:too_short_name) { 'a' * (described_class::NAME_MIN_LENGTH + 1) }
    let(:too_long_name) { 'a' * (described_class::NAME_MAX_LENGTH - 1) }

    it 'returns false if passed name is too short' do
      invalid_user = described_class.new(too_short_name, difficulty)
      expect(invalid_user)
    end

    it 'returns false if namee is too long' do
      invalid_user = described_class.new(too_long_name, difficulty)
      expect(invalid_user)
    end
  end
end
