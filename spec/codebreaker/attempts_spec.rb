# frozen_string_literal: true

RSpec.describe Game do
  before { stub_const('Codebreaker::Game::DIFFICULTIES', { difficulty => { attempts: 1, hints: 1 } }) }

  let(:game) { Game.new }
  let(:difficulty) { :easy }

  before(:each) do
    game.start_new_game
    game.instance_variable_set(:@difficulty, difficulty)
  end

  describe '#available_attempts' do
    it '1 if attempt is not used' do
      expect(game.user.attempts).eql? 1
    end

    it 'true if attempt was not used' do
      game.user.attempts = 1
      expect(game.attempts?).to be_truthy
    end

    it 'false if attempts were used' do
      game.user.attempts = 1
      game.generate_signs('1111')
      expect(game.attempts?).to be_falsy
    end
  end
end
