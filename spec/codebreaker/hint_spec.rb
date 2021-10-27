# frozen_string_literal: true

RSpec.describe Game do
  let(:difficulty) { Codebreaker::Difficulty.new('easy') }
  let(:game) { described_class.new(Codebreaker::User.new('manfly'), difficulty) }

  describe '#hint' do
    context 'when hints are absent' do
      it 'raise HintError' do
        game.instance_variable_set(:@hints, 0)
        expect { game.hint }.to raise_error(HintError)
      end
    end

    it 'reduces hint counter by 1' do
      expect { game.hint }.to change(game, :hints).by(-1)
    end

    it 'returns integer' do
      expect(game.hint.class).to eq(Integer)
    end

    it 'reduces hint_number size by 1' do
      expect { game.hint }.to change { game.hint_number.size }.by(-1)
    end

    it 'returns number included in secret_code' do
      expect(game.secret_code).to include(game.hint)
    end
  end
end
