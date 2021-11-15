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
        expect { game.create_user(invalid_name, difficulty) }.to raise_error(Codebreaker::Errors::ClassValidError)
      end
    end
  end

  describe '#create_difficulty' do
    context 'success' do
      it 'should have choose right name difficulty' do
        expect do
          game.create_difficulty(name).not_to raise_error(Codebreaker::Errors::InvalidDifficultyError)
        end
      end
      it 'should have choose right attempts' do
        expect(difficulty.attempts).to eq(15)
      end

      it 'should have choose right hints' do
        expect(difficulty.hints).to eq(2)
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
      context 'guess is valid' do
        it '#take_attempt not change @attempts value if called for the first time' do
          game.stub(:take_attempt)
          expect { game.take_attempt(:win?) }.not_to(change { game.instance_variable_get(:@attempts) })
        end
      end
      context 'true' do
        keys = %w[hints attempts secret_code]

        keys.each do |key|
          it "return value should include :#{key}" do
            game.stub(:take_attempt)
            subject.instance_variable_set(:@secret_code, '1234')
            expect(game.take_attempt([:"#{key}"])).to be_nil
          end
        end
        context 'guess is invalid' do
          it 'returns nil' do
            game.stub(:take_attempt)
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

        it '' do
          [1, 2, 3, 4].reverse.each do |hint|
            expect(game.take_hint).to eq hint
          end
        end
      end
    end

    describe '#win?' do
      before do
        game.instance_variable_set(:@secret_code, [1, 2, 3, 4])
      end

      it 'returns true if user wins game' do
        game.stub(:take_attempt)
        game.take_attempt(@secret_code)
        expect(game.win?).to be false
      end

      it 'returns false if the user has not yet won a game' do
        game.stub(:take_attempt)
        game.take_attempt(@secret_code)
        expect(game.win?).to be false
      end

      context 'should be false if previous guess was not success' do
        specify do
          game.instance_variable_set(:@result, '+++-')
          expect(game.win?).to be_falsey
        end

        specify do
          game.instance_variable_set(:@result, nil)
          expect(game.win?).to be_falsey
        end
      end
    end

    describe '#lose?' do
      it 'returns true if user loses game' do
        game.instance_variable_set(:@attempts, 0)
        expect(game.lose?).to be false
      end

      it 'returns false if the user has not yet lose a game' do
        game.instance_variable_set(:@attempts, 1)
        expect(game.lose?).to be false
      end

      context 'should return false' do
        specify 'guesses quantity is 0 and answer is "++++"' do
          game.instance_variable_set(:@result, '++++')
          expect(game.lose?).to be_falsey
        end

        specify 'guesses quantity grate than 0 and answer is "++++"' do
          game.instance_variable_set(:@result, '++++')
          expect(game.lose?).to be_falsey
        end

        specify 'guesses quantity grate than 0 and answer is "++-"' do
          game.instance_variable_set(:@result, '++-')
          expect(game.lose?).to be_falsey
        end
      end
    end
  end
end
