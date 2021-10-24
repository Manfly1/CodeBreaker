# frozen_string_literal: true

module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }
    let(:test_class) { Class.new { include Storage }.new }

    context 'wrong phase error' do
      before { game.instance_variable_set(:@phase, Constants::LOSE) }

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
        expect { game.start_new_game }.to change { game.phase }.from(Constants::START_GAME).to(Constants::GAME)
      end

      it 'jumps from game phase to winning phase' do
        game.start_new_game
        game.instance_variable_set(:@code, '1642')
        expect { game.end_game('1642') }.to change { game.phase }.from(Constants::GAME).to(Constants::WIN)
      end

      it 'jumps from game phase to losing phase' do
        game.start_new_game
        game.instance_variable_set(:@code, '1642')
        expect { game.end_game('1624') }.to change { game.phase }.from(Constants::GAME).to(Constants::LOSE)
      end
    end
  end
end
