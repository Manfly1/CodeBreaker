# frozen_string_literal: true

RSpec.describe Game do
  subject(:game) {}

  let(:user) { Codebreaker::User.new(Faker::Name.first_name) }
  let(:difficulty) { Codebreaker::Difficulty.new(name: 'Easy', attempts: 10, hints: 2) }

  describe '#valid?' do
    subject(:invalid_game) { described_class.new('easy', Faker::Name.first_name) }

    it 'returns true if instance is valid' do
      expect(game)
    end
  end

  describe '#start' do
    it 'generates code' do
      expect(@secret_code)
    end

    it 'has a version number' do
      expect(Codebreaker::VERSION).not_to be nil
    end

    it 'initializes attempts' do
      expect(@attempts_amount)
    end

    it 'initializes hints' do
      expect(@hints_amount)
    end
  end

  describe '#save_statistic' do
    it 'can save user statistic' do
      expect { game.save }
    end
  end

  describe '#make_turn' do
    let(:guess) do
      guess = Codebreaker::CodeGenerator
      allow(guess).to receive(@secret_code).and_return([1, 2, 3, 4])
      guess
    end
    let(:match_result) { '++++' }

    before do
      matcher = instance_double(Codebreaker::CodeMatcher)
      allow(matcher).to receive(:match_codes).and_return(match_result)
      allow(Codebreaker::CodeMatcher).to receive(:new).and_return(matcher)
    end
  end
end
