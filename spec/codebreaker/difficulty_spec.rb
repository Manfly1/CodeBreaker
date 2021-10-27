# frozen_string_literal: true

RSpec.describe Codebreaker::Difficulty do
  let(:difficulty) { described_class.new('easy') }

  describe '.validate' do
    context 'when given unknown difficulty' do
      it 'raise DifficultyError' do
        expect { described_class.validate('hardveryhard') }.to raise_error(DifficultyError)
      end
    end
  end

  describe '#attempts' do
    it 'return Integer' do
      expect(difficulty.attempts.class).to eq(Integer)
    end
  end

  describe '#hints' do
    it 'return Integer' do
      expect(difficulty.hints.class).to eq(Integer)
    end
  end
end
