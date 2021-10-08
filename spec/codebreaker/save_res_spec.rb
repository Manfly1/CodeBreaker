# frozen_string_literal: true

RSpec.describe Codebreaker::SaveRes do
  let(:loader) { described_class }
  let(:difficulty) { Codebreaker::Game::DIFFICULTIES.keys.first }
  let(:game) { Codebreaker::Game.new(difficulty: difficulty, user: user) }
  let(:user) { instance_double("User") }

  describe "#load" do
    context "when saving and loading file" do
      before { game.save_game }

      it { expect(described_class.new.load).to include(game.class) }
    end

    context "saving file" do
      before do
        game.save_game
      end

      it { expect(ENV["DB_PATH"]).to be_a_directory }
    end
  end
end
