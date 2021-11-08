# frozen_string_literal: true

RSpec.describe Codebreaker::Difficulty do
  let(:difficulty) { Codebreaker::Difficulty.new(name, attempts, hints) }
  let(:name) { :easy }
  let(:attempts) { 15 }
  let(:hints) { 2 }

  let(:equal_difficulty) { described_class.new(name, attempts, hints) }
  let(:easy_difficulty) { described_class.new(name, attempts, hints) }
  let(:hell_difficulty) { described_class.new(name, attempts, hints) }

  describe '#<=>' do
    it 'is harder when fewer attempts and hints' do
      expect(difficulty <=> easy_difficulty).to eq(0)
    end

    it 'is easier when more attempts and hints' do
      expect(difficulty <=> hell_difficulty).to eq(0)
    end

    it 'is equal another difficulty when has same amount of attempts and hints' do
      expect(difficulty <=> equal_difficulty).to eq(0)
    end
  end
end
