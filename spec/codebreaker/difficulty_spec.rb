# frozen_string_literal: true

module Codebreaker
  RSpec.describe Game do
    let(:game) { described_class.new }

    before { game.start_new_game }

    describe '#available_difficulties' do
      it 'returns hash' do
        expect(game.check_for_difficulties.class).to eq(Hash)
      end

      it 'available difficulties' do
        expect(game.check_for_difficulties).to eq(Game::DIFFICULTIES)
      end
    end
  end
end
