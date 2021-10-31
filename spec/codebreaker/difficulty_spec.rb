# frozen_string_literal: true

RSpec.describe Codebreaker::Difficulty do
  subject(:difficulty) { described_class.new(name: 'Medium', attempts: 10, hints: 2) }

  let(:equal_difficulty) { described_class.new(name: 'Normal', attempts: 10, hints: 2) }
  let(:easy_difficulty) { described_class.new(name: 'Easy', attempts: 15, hints: 3) }
  let(:hell_difficulty) { described_class.new(name: 'Hell', attempts: 5, hints: 1) }

  describe '#valid?' do
    let(:valid_name) { 'Easy' }
    let(:valid_attempts) { 10 }
    let(:valid_hints) { 5 }
    let(:invalid_name) { '' }
    let(:invalid_attempts) { 0 }
    let(:invalid_hints) { -1.65 }

    it 'returns true if instance is valid' do
      valid_difficulty = described_class.new(name: valid_name, attempts: valid_attempts, hints: valid_hints)
      expect(valid_difficulty)
    end
  end

  describe '#<=>' do
    it 'is harder when fewer attempts and hints' do
      expect(difficulty <=> easy_difficulty).to eq(-1)
    end

    it 'is easier when more attempts and hints' do
      expect(difficulty <=> hell_difficulty).to eq 1
    end

    it 'is equal another difficulty when has same amount of attempts and hints' do
      expect(difficulty <=> equal_difficulty).to eq 0
    end
  end
end
