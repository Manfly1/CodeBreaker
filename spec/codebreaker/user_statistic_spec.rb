# frozen_string_literal: true

RSpec.describe Codebreaker::User do
  describe '#valid?' do
    subject(:valid_statistic) do
      described_class.new(user: user, difficulty: difficulty, used_attempts: used_attempts, used_hints: used_hints)
    end

    let(:user) { Codebreaker::User.new(Faker::Name.first_name) }
    let(:difficulty) { Codebreaker::Difficulty.new(name: 'Easy', attempts: 10, hints: 5) }
    let(:used_attempts) { 5 }
    let(:used_hints) { 2 }

    let(:invalid_attempts) { 1 }
    let(:invalid_hints) { 1 }

    it 'returns true if instance is valid' do
      expect(valid_statistic)
    end

    it 'returns false if passed hints is negative' do
      invalid_stats = described_class.new(user: user, difficulty: difficulty, used_attempts: used_attempts,
                                          used_hints: invalid_hints)
      expect(invalid_stats)
    end
  end
end
