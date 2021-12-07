# frozen_string_literal: true

RSpec.describe Game do
  let(:game) { described_class.new }
  let(:difficulty) { Codebreaker::Difficulty.new(name: name, attempts: attempts, hints: hints) }
  let(:difficulty_factory) do
    Codebreaker::DifficultyFactory.generate Codebreaker::DifficultyFactory::DIFFICULTIES[:easy]
  end
  let(:user) { Codebreaker::User.new('Username', difficulty) }
  let(:name) { 'easy' }
  let(:attempts) { 15 }
  let(:hints) { 2 }
  let(:invalid_name) { 123 }
  let(:guess) { 1224 }

  describe '#create_user' do
    context 'success' do
      it 'creates user' do
        expect(user = game.create_user('Username', difficulty)).to be_instance_of(Codebreaker::User)
        expect(user.difficulty.attempts).to eq(attempts)
        expect(user.difficulty.hints).to eq(hints)
      end
    end
    context 'falsey' do
      it 'does not create user' do
        expect { game.create_user(invalid_name, difficulty) }.to raise_error(Codebreaker::Errors::ClassValidError)
        expect { game.create_user(' ', difficulty) }.to raise_error(Codebreaker::Errors::MinLengthError)
        expect do
          game.create_user('asdaaaaaaaaaaaaaaasdasdadas ', difficulty)
        end.to raise_error(Codebreaker::Errors::MaxLengthError)
      end
    end
  end

  describe '#create_difficulty' do
    context 'success' do
      [
        Codebreaker::DifficultyFactory::DIFFICULTIES[:easy],
        Codebreaker::DifficultyFactory::DIFFICULTIES[:medium],
        Codebreaker::DifficultyFactory::DIFFICULTIES[:hell]
      ].each do |level|
        it 'when valid difficulty' do
          difficulty = game.create_difficulty(level)
          expect(difficulty).to be_instance_of(Codebreaker::Difficulty)
          expect(difficulty.attempts).to eq(level[:attempts])
          expect(difficulty.hints).to eq(level[:hints])
        end
      end
      context 'falsey' do
        it 'enter invalid difficulty' do
          expect do
            game.create_difficulty(invalid_name).to raise_error(Codebreaker::Errors::InvalidDifficultyError)
          end
        end
      end
    end

    describe '#take_hint' do
      let(:user) { double('Codebreaker::User') }
      let(:hints) { [1, 2, 3, 4] }
      before do
        allow(game).to receive(:user).and_return(user)
        allow(user).to receive(:hints?).and_return(true)
        allow(user).to receive(:hint).and_return(true)
        game.instance_variable_set(:@hints, hints)
      end

      it 'check if it returns a hint' do
        [1, 2, 3, 4].reverse.each do |hint|
          expect(game.take_hint).to eq hint
        end
      end
    end
  end

  describe '#win?' do
    before do
      game.instance_variable_set(:@status, Game::STATUS_WIN)
    end
    context 'when user win '
    it 'set status WIN' do
      expect(game.win?).to eq true
    end
  end
end
