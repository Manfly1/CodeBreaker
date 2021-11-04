# frozen_string_literal: true

RSpec.describe Game do
  let(:game) { described_class.new }

  describe '#secret_code' do
    context 'when game starts it initializes with secret code' do
      subject(:game_secret_code) { @secret_code }

      let(:secret_code) { '6616' }

      it 'has secret number' do
        allow_any_instance_of(described_class).to receive(:generate_secret_code).and_return(@secret_code)
        expect(@secret_code).to eq(@secret_code)
      end
    end
    context '#when generate secret code' do
      it 'should not be empty' do
        expect(game.instance_variable_get(:@secret_code)).not_to be_empty
      end
      it 'should saves 4 numbers secret code' do
        expect(game.instance_variable_get(:@secret_code).length).to eq 4
      end
      it 'should saves secret code with numbers from 1 to 6' do
        game.instance_variable_get(:@secret_code).each do |number|
          expect(number).to be_between(1, 6).inclusive
        end
      end
    end
  end

  describe '#create_difficulty' do
    context 'when correct difficulty' do
      it 'should create game with different difficulty' do
        Codebreaker::DifficultyFactory::DIFFICULTIES.each do |_name, difficulty|
          current_game = described_class.new
          expect(current_game.attempts_amount).to eq difficulty[:attempts_amount]
          expect(current_game.hints_amount).to eq difficulty[:hints_amount]
        end
      end
    end
  end
  context 'take_attempt' do
    it 'decreases attempts by one when used' do
      subject.instance_variable_set(:@attempts_amount, 3)
      expect { subject.attempts_amount }.to change(subject, :attempts_amount).by(0)
    end
  end

  context 'take_hint' do
    it 'show hint' do
      game.create_difficulty(Codebreaker::DifficultyFactory::DIFFICULTIES[:hell])
      game.hints_amount
      expect(game.hints_amount) == 1
    end
    it 'hint_number is equal to secret_code' do
      expect(@hint).to eq(@secret_code)
    end
  end

  describe '#win? or lose?' do
    subject(:player_win?) { game.win? }

    before { game.instance_variable_set(:@result, result) }

    context 'when player wins' do
      let(:result) { '++++' }

      it { expect(player_win?).to be_falsey }
      it 'return false' do
        expect(game.win?).to be false
      end
    end

    context 'when player loose' do
      let(:result) { '--' }

      it { expect(player_win?).to be_falsey }
      it 'return false' do
        expect(game.lose?).to be false
      end
    end
  end
end
