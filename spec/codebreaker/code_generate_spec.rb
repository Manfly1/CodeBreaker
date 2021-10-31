# frozen_string_literal: true

RSpec.describe Codebreaker::CodeGenerator do
  subject(:generator) { described_class.new }

  describe '#valid?' do
    subject(:invalid_generator) { described_class.new }

    it 'returns true if instance is valid' do
      expect(generator)
    end

    it 'returns false if instance is not valid' do
      expect(invalid_generator)
    end
  end
end
