# frozen_string_literal: true

RSpec.describe Game do
  let(:game) { described_class.new }
  let(:difficulty) { Codebreaker::Difficulty.new(name, attempts, hints) }
  let(:name) { :easy }
  let(:attempts) { 15 }
  let(:hints) { 2 }
  let(:invalid_difficulty) { Codebreaker::Difficulty.new(invalid_name, invalid_attempts, invalid_hints) }
  let(:invalid_name) { 'I' }
  let(:invalid_attempts) { 20 }
  let(:invalid_hints) { 0 }

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
        expect(invalid_difficulty.attempts).not_to eq(attempts)
        expect(invalid_difficulty.hints).not_to eq(hints)
      end
    end
  end

  describe "#create_difficulty" do
    
    context "success" do
  
        it 'should have choose right attempts' do
          expect(difficulty.attempts).to eq(15)
        end
    
        it 'should have choose right hints' do
          expect(difficulty.hints).to eq(2)
        end
    context "falsey" do

      it "enter invalid difficulty" do
          expect { game.create_difficulty(:invalid_name) }.to raise_error(InvalidDifficultyError)
         end    
    end
  end

  describe '#take_attempt' do
    it { expect { game.take_attempt([1, 1, 1, 1]) }.to change{difficulty.attempts}.by(-1) }
  end

  describe '#take_hint' do
   

      it 'hint_number is equal to secret_code' do
        expect(game.instance_variable_get(:@secret_code)).to include(difficulty.hints)
      end
      it 'has zero used attempts and used hints by default' do
        game = Codebreaker::User.new('name', difficulty)
        expect(game.used_attempts).to eq(0)
        expect(game.used_hints).to eq(0)
      end
      it 'when check_hints_return_nil_with_zero_hints' do
        game.instance_variable_set(:@hints, 0)
        expect(difficulty.hints).to eq(2)
       end
      it 'have limited amount of hints' do
        Codebreaker::DifficultyFactory::DIFFICULTIES.each do |_level|
          difficulty.hints do
            expect(difficulty.hints).to matcher(/^[0-9]$/)
          end
          expect { difficulty.hints }
        end
      end
  end

  describe '#win? or #lose?' do
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
    end
  end
end
end
