# frozen_string_literal: true

RSpec.describe Codebreaker::DifficultyFactory do
  subject(:difficulty) { described_class.new(name: 'Medium', attempts: 10, hints: 2) }

  let(:equal_difficulty) { described_class.new(name: 'Normal', attempts: 10, hints: 2) }
  let(:easy_difficulty) { described_class.new(name: 'Easy', attempts: 15, hints: 3) }
  let(:hell_difficulty) { described_class.new(name: 'Hell', attempts: 5, hints: 1) }

  describe '.generate' do
    it 'returns game with easy difficulty' do
      expect(described_class.generate(:easy))
    end

    it 'returns game with medium difficulty' do
      expect(described_class.generate(:medium))
    end

    it 'returns game with hell difficulty' do
      expect(described_class.generate(:hell))
    end

    it 'returns nil if unknown difficulty keyword passed' do
      expect(described_class.generate(:invalid)).to be_nil
    end
  end
end
