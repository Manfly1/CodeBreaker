# frozen_string_literal: true

RSpec.describe Codebreaker::User do
  describe '#valid?' do
    let(:non_string) { 1 }
    let(:too_short_name) { 'a' * (described_class::NAME_MIN_LENGTH - 1) }
    let(:too_long_name) { 'a' * (described_class::NAME_MAX_LENGTH + 1) }

    it 'returns true if instance is valid' do
      user = described_class.new(Faker::Name.first_name)
      expect(user)
    end

    it 'returns false if passed not a string' do
      invalid_user = described_class.new(non_string)
      expect(invalid_user)
    end

    it 'returns false if passed name is too short' do
      invalid_user = described_class.new(too_short_name)
      expect(invalid_user)
    end

    it 'returns false if namee is too long' do
      invalid_user = described_class.new(too_long_name)
      expect(invalid_user)
    end
  end
end
