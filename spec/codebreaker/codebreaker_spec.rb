# frozen_string_literal: true

RSpec.describe Game do
  subject(:game) { described_class.new(difficulty, user) }

  let(:difficulty) { Codebreaker::Difficulty.new(name: 'Easy', attempts: 10, hints: 2) }
  let(:user) { Codebreaker::User.new(Faker::Name.first_name) }

  describe '#valid?' do
    subject(:invalid_game) { described_class.new('easy', Faker::Name.first_name) }

    it 'returns true if instance is valid' do
      expect(game).to be_valid
    end
  end

  describe '#start' do
    it 'generates code' do
      old_code = game.code
      game.start
      expect(game.code).not_to eq old_code
    end

    it 'has a version number' do
      expect(Codebreaker::VERSION).not_to be nil
    end

    it 'initializes attempts' do
      game.start
      expect(game.attempts_amount).to eq difficulty.attempts
    end

    it 'initializes hints' do
      game.start
      expect(game.hints_amount).to eq difficulty.hints
    end
  end

  context 'when game starts' do
    before do
      store = instance_double(Codebreaker::Storage)
      allow(store).to receive(:data).and_return({ user_statistics: [] })
      allow(store).to receive(:save)
      allow(Codebreaker::Storage).to receive(:new).and_return(store)
      game.start
    end

    describe '#restart' do
      it 'changes code' do
        old_code = game.code
        game.restart
        expect(game.code).not_to eq old_code
      end

      it 'restore attempts' do
        game.restart
        expect(game.attempts_amount).to eq difficulty.attempts
      end

      it 'restore hints' do
        game.restart
        expect(game.hints_amount).to eq difficulty.hints
      end
    end

    describe '#save_statistic' do
      it 'can save user statistic' do
        expect { game.save_statistic }.not_to raise_error
      end
    end

    describe '#user_statistic' do
      it 'returns game statistic' do
        expect(described_class.user_statistic).to be_an Array
      end
    end

    describe '#take_hint' do
      let(:hints_variable) { :@hints_amount }
      let(:expected_no_hints_error) { Codebreaker::NoHintsLeftError }

      it 'can return one of the code numbers' do
        expect(game.code).to include(game.take_hint)
      end
    end

    describe '#make_turn' do
      let(:guess) do
        guess = instance_double(Codebreaker::Guess)
        allow(guess).to receive(:code).and_return([1, 2, 3, 4])
        guess
      end
      let(:match_result) { '++++' }

      before do
        matcher = instance_double(Codebreaker::CodeMatcher)
        allow(matcher).to receive(:match_codes).and_return(match_result)
        allow(Codebreaker::CodeMatcher).to receive(:new).and_return(matcher)
      end

      it 'returns codes match' do
        expect(game.make_turn(guess)).to be_a(String)
      end
    end

    describe '#win?' do
      let(:guess) do
        guess = instance_double(Codebreaker::Guess)
        allow(guess).to receive(:code).and_return(game.code)
        guess
      end

      it "returns false if player has't won" do
        expect(game).not_to be_win
      end

      it 'returns true if player has won' do
        game.instance_variable_set(:@guess, guess)
        expect(game).to be_win
      end
    end

    describe '#lose?' do
      it "returns false if player has't lost" do
        expect(game).not_to be_lose
      end

      it 'returns true if player has lost' do
        game.instance_variable_set(:@attempts_amount, 0)
        expect(game).to be_lose
      end
    end
  end
end
