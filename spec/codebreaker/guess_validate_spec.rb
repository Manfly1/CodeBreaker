# frozen_string_literal: true

RSpec.describe Codebreaker::DataMatcher do
  describe '.validate' do
    context 'when guess is not equal to CODE_LENGTH' do
      it 'raise LengthError' do
        expect { described_class.validate(1_234_567_890) }.to raise_error(LengthError)
      end
    end
  end
end
