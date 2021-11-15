# frozen_string_literal: true

RSpec.describe Codebreaker::DifficultyFactory do
  let(:difficulty) { Codebreaker::DifficultyFactory }

  subject(:easy_difficulty) { described_class.generate Codebreaker::DifficultyFactory::DIFFICULTIES[:easy] }
  subject(:medium_difficulty) { described_class.generate Codebreaker::DifficultyFactory::DIFFICULTIES[:medium] }
  subject(:hell_difficulty) { described_class.generate Codebreaker::DifficultyFactory::DIFFICULTIES[:hell] }

  context 'difficulty apply' do
    it 'easy level' do
      easy_difficulty
      expect(easy_difficulty.hints).to eq(2)
      expect(easy_difficulty.attempts).to eq(15)
    end
    it 'medium level' do
      medium_difficulty
      expect(medium_difficulty.hints).to eq(1)
      expect(medium_difficulty.attempts).to eq(10)
    end
    it 'hell level' do
      hell_difficulty
      expect(hell_difficulty.hints).to eq(1)
      expect(hell_difficulty.attempts).to eq(5)
    end
  end

  context 'generate invalid difficulty' do
    it 'error if difficulty invalid' do
      error = Codebreaker::Errors::InvalidDifficultyError
      expect { difficulty.generate(Codebreaker::DifficultyFactory::DIFFICULTIES[:invalid]) }.to raise_error(error)
    end
  end
end
