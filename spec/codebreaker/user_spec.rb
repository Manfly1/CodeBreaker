# frozen_string_literal: true

RSpec.describe Codebreaker::User do
  let(:user) { described_class.new('Manfly') }

  describe '.initialize' do
    it 'has name field' do
      expect(user.instance_variables).to include(:@name)
    end

    it 'name is string' do
      expect(user.name.class).to eq(String)
    end

    it 'raises ClassError' do
      expect { described_class.validate('ar') }.to raise_error(LengthError)
    end
  end
end
