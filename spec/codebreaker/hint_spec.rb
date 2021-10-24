# frozen_string_literal: true

module Codebraker
  RSpec.describe Game do
    before { stub_const('Codebreaker::Game::DIFFICULTIES', { difficulty => { attempts: 1, hints: 1 } }) }

    let(:game) { described_class.new }
    let(:difficulty) { :easy }

    before(:each) do
      game.start_new_game
      game.instance_variable_set(:@difficulty, difficulty)
    end

    describe '#hint' do
      it 'hint is available' do
        expect(game.instance_variable_get(:@code)).to include game.show_hint
      end

      it 'returns 0 when all hints are used' do
        game.user.hints = 1
        game.show_hint

        expect(game.user.hints).to eq 0
      end
    end
  end
end
