# frozen_string_literal: true

RSpec.describe Game do
  let(:difficulty) { Codebreaker::Difficulty.new('easy') }
  let(:game) { described_class.new(Codebreaker::User.new('manfly'), difficulty) }

  describe '.initialize' do
    it 'secret is an Array' do
      expect(game.secret_code.class).to eq(Array)
    end

    it 'secret_code size equal to CODE_LENGTH' do
      expect(game.secret_code.size).to eq(described_class::CODE_LENGTH)
    end

    it 'each element of secret is in CODE_RANGE' do
      game.secret_code.each { |digit| expect(described_class::CODE_RANGE).to include(digit) }
    end

    it 'player is instance of User class' do
      expect(game.user.class).to eq(Codebreaker::User)
    end

    it 'difficulty is instance of Difficulty class' do
      expect(game.difficulty.class).to eq(Codebreaker::Difficulty)
    end

    it 'hint_number is equal to secret_code' do
      expect(game.hint_number).to eq(game.secret_code)
    end
  end
end
