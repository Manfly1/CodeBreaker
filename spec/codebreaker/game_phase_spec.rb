# frozen_string_literal: true

module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }
    let(:test_class) { Class.new { include Storage }.new }

    context 'wrong phase error' do
      before { game.instance_variable_set(:@phase, Game::LOSE_STATUS) }

      it 'raises WrongPhaseError when user to start phase' do
        expect { game.start_new_game }.to raise_error WrongPhaseError
      end

      it 'raises WrongPhaseError when user to guessing phase' do
        expect { game.generate_signs('1324') }.to raise_error WrongPhaseError
      end

      it 'raises WrongPhaseError when user to saving results phase' do
        expect { test_class.save_file(game) }.to raise_error WrongPhaseError
      end
    end

    context 'jump to the other phase' do
      it 'jumps from start phase to game phase' do
        expect { game.start_new_game }.to change { game.phase }.from(Game::START_STATUS).to(Game::GAME_STATUS)
      end

      it 'jumps from game phase to winning phase' do
        game.start_new_game
        game.instance_variable_set(:@code, '1642')
        expect { game.end_game('1642') }.to change { game.phase }.from(Game::GAME_STATUS).to(Game::WIN_STATUS)
      end

      it 'jumps from game phase to losing phase' do
        game.start_new_game
        game.instance_variable_set(:@code, '1642')
        expect { game.end_game('1624') }.to change { game.phase }.from(Game::GAME_STATUS).to(Game::LOSE_STATUS)
      end
    end
  end
end
