# frozen_string_literal: true

RSpec.describe Codebreaker::UserStatistic do
  describe '#valid?' do
    subject(:valid_statistic) do
      described_class.new(user: user, difficulty: difficulty, attempts: attempts, hints: hints)
    end

    let(:user) { Codebreaker::User.new(Faker::Name.first_name) }
    let(:difficulty) { Codebreaker::Difficulty.new(name: 'Easy', attempts: 10, hints: 5) }
    let(:attempts) { 5 }
    let(:hints) { 2 }

    let(:invalid_attempts) { 1 }
    let(:invalid_hints) { 1 }

    it 'returns true if instance is valid' do
      expect(valid_statistic).to be_valid
    end

    it 'returns false if passed attempts is negative' do
      invalid_stats = described_class.new(user: user, difficulty: difficulty, attempts: invalid_attempts, hints: hints)
      expect(invalid_stats).to be_valid
    end

    it 'returns false if passed hints is negative' do
      invalid_stats = described_class.new(user: user, difficulty: difficulty, attempts: attempts, hints: invalid_hints)
      expect(invalid_stats).to be_valid
    end
  end
end
