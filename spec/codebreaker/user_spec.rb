# frozen_string_literal: true

module Codebreaker
  RSpec.describe Validation do
    let(:test_name) { Class.new { extend Validation } }

    describe '#validate_name' do
      it 'raise LengthError if name has less than 3 letters' do
        expect { test_name.validate_name('Mo') }.to raise_error LengthError
      end

      it 'raise LengthError if name has more than 20 letters' do
        expect { test_name.validate_name('Luvsanperenleizhangtsan') }.to raise_error LengthError
      end
    end
  end
end
