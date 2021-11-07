# frozen_string_literal: true

RSpec.describe Game do
  let(:game) { described_class.new('And', :easy) }

  describe 'create_user' do
    it 'when we check that the username is entered incorrectly' do
      expect { Game.new('') }.to raise_error
      expect { Game.new('ThisIsWayTooLongUserName') }.to raise_error
    end
  end

  describe 'create_difficulty' do
    it 'forbid incorrect difficulties' do
      expect { Game.new('Username', :easy) }.not_to raise_error
      expect { Game.new('Username', :medium) }.not_to raise_error
      expect { Game.new('Username', :hell) }.not_to raise_error

      expect { Game.new('Username', 'easy') }.not_to raise_error
      expect { Game.new('Username', 'medium') }.not_to raise_error
      expect { Game.new('Username', 'hell') }.not_to raise_error
    end

    it "has 'easy' difficulty" do
      easy_game = Game.new('UserName', :easy)
      expect(easy_game.difficulty).to eq(:easy)
      expect(easy_game.attempts).to eq(nil)
    end

    it "has 'medium' difficulty" do
      medium_game = Game.new('UserName', :medium)
      expect(medium_game.difficulty).to eq(:medium)
      expect(medium_game.attempts).to eq(nil)
    end

    it "has 'hell' difficulty" do
      hell_game = Game.new('UserName', :hell)
      expect(hell_game.difficulty).to eq(:hell)
      expect(hell_game.attempts).to eq(nil)
    end

    context 'take_attempt' do
      it 'decreases attempts by one when used' do
        game.instance_variable_set(:@attempts, 3)
        expect { game.attempts }.to change(game, :attempts).by(0)
      end
      it 'has zero used attempts by default' do
        game = Game.new('UserName', :easy)
        expect(game.attempts).to eq(nil)
      end
    end

    context 'take_hint' do
      it 'show hint' do
        game.create_difficulty(Codebreaker::DifficultyFactory::DIFFICULTIES[:hell])
        game.hints
        expect(game.hints) == 1
      end
      it 'hint_number is equal to secret_code' do
        expect(@hint).to eq(@secret_code)
      end
      it 'has zero used attempts and used hints by default' do
        game = Codebreaker::User.new
        expect(game.used_attempts).to eq(0)
        expect(game.used_hints).to eq(0)
      end
      it 'have limited amount of hints' do
        Codebreaker::DifficultyFactory::DIFFICULTIES.each do |_level|
          game = Game.new('HintUser', :easy)
          game.hints do
            expect(game.hint).to matcher(/^[0-9]$/)
          end
          expect { game.hint }
        end
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

      context 'when player lose' do
        let(:result) { '--' }

        it { expect(player_win?).to be_falsey }
        it 'return false' do
          expect(game.lose?).to be false
        end
        it 'ifs attempts is not equal zero' do
          game.instance_variable_set(:@attempts, 0)
          expect(game.lose?).to eq(false)
        end
      end
    end
  end
end
