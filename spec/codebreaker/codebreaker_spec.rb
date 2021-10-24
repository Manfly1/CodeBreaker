# frozen_string_literal: true

RSpec.describe Game do
  let(:game) { Game.new }

  before do
    game.start_new_game
    game.instance_variable_set(:@code, '3142')
  end

  describe '#start_new_game' do
    it 'generate code' do
      expect(game.instance_variable_get(:@code)).not_to be_empty
    end

    it '4 digit' do
      expect(game.instance_variable_get(:@code).size).to eq Game::CODE_LENGTH
    end

    it 'number with 1 to 6 digits' do
      expect(game.instance_variable_get(:@code)).to match(/[1-6]+/)
    end
  end

  context 'end of game' do
    it 'returns true if the guess is right' do
      expect(game.won?('3142')).to be_truthy
    end

    it 'returns false if the guess us wrong' do
      expect(game.won?('3214')).to be_falsy
    end

    it 'player has not lose' do
      game.user.attempts = 1
      expect(game.lose?).to be_falsy
    end

    it 'player has lose' do
      game.user.attempts = 0
      expect(game.lose?).to be_truthy
    end
  end
end
