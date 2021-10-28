# frozen_string_literal: true

RSpec.describe Codebreaker::Entity do
  subject(:validatable_instance) { described_class.new }

  describe '#valid?' do
    it 'validates itself' do
      expect(validatable_instance).to be_valid
    end
  end
end
