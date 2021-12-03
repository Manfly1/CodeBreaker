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
        expect(game.create_user('Username', difficulty)).to be_instance_of(Codebreaker::User)
        expect(difficulty.attempts).to eq(attempts)
        expect(difficulty.hints).to eq(hints)
      end
    end
    context 'falsey' do

      it 'creates user' do
        expect { game.create_user(invalid_name, difficulty) }.to raise_error(Codebreaker::Errors::ClassValidError)
        expect { game.create_user(' ', difficulty) }.to raise_error(Codebreaker::Errors::MinLengthError)
        expect { game.create_user('asdaaaaaaaaaaaaaaasdasdadas ', difficulty) }.to raise_error(Codebreaker::Errors::MaxLengthError)
        expect { game.create_user(invalid_name, difficulty) }.to raise_error(Codebreaker::Errors::ClassValidError)
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
            expect(game.create_difficulty(level))
            end
          
        end
        it 'has attempts for each difficulty' do
          expect(difficulty.attempts).to eq(Codebreaker::DifficultyFactory::DIFFICULTIES[:easy][:attempts])
        end
    
        it 'has hints for each difficulty' do
          expect(difficulty.hints).to eq(Codebreaker::DifficultyFactory::DIFFICULTIES[:easy][:hints])
        end
      context 'falsey' do
        it 'enter invalid difficulty' do
          expect do
            game.create_difficulty(invalid_name).to raise_error(Codebreaker::Errors::InvalidDifficultyError)
          end
        end
      end
    end

    describe '#take_attempt' do
      context 'true' do
        let(:user) { double('Codebreaker::User') }

        before do
          allow(game).to receive(:user).and_return(user)
          allow(user).to receive(:attempts?).and_return(true)
          allow(user).to receive(:attempt).and_return(true)
          game.instance_variable_set(:@secret_code, 1234)
          game.instance_variable_set(:@user, user)
          game.instance_variable_set(:@attempts, attempts)
        end

        it 'check if you made a attempt' do
          expect ( game.take_attempt(1234)).to eq('++++')
        end

        it 'attempts counter changes by 1' do
          expect { game.take_attempt(guess) }.to change { user.instance_variable_get(:@attempts_used) }.by(1)
        end

        context 'false' do

          it 'enter string value' do
            expect(game.take_attempt('invalid_code')).to be_falsey
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

    describe '#win?, lose?' do
      it 'input win message' do
        expect(game.instance_variable_set(:@status, Game::STATUS_WIN)).to eq :win
      end
    end

    context 'when user lose' do
      it 'input lose message' do
        (Codebreaker::DifficultyFactory::DIFFICULTIES[:easy][:attempts] - 1).times { game.take_attempt(guess) }
        expect(game.take_attempt(guess)[:status]).to eq(Game::STATUS_LOSE)
      end
    end
  end
end
