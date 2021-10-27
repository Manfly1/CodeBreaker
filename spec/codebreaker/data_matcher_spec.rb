# frozen_string_literal: true

RSpec.describe Codebreaker::DataMatcher do
  describe '#check_guess' do
    [
      ['5179', [2, 2, 2, 2], ''],
      ['7253', [1, 1, 1, 3], '+'],
      ['6881', [2, 6, 6, 6], '-'],
      ['8275', [1, 2, 5, 6], '+-'],
      ['2667', [1, 6, 6, 1], '++'],
      ['2516', [6, 1, 4, 3], '--'],
      ['1239', [1, 2, 3, 5], '+++'],
      ['1274', [1, 2, 4, 8], '++-'],
      ['5143', [5, 4, 1, 3], '++--'],
      ['5634', [3, 4, 5, 6], '----'],
      ['1234', [1, 2, 3, 4], '++++']
    ].each do |item|
      it 'returns correct result depends on input' do
        guess = described_class.new(item[0], item[1])
        expect(guess.check_guess).to eq item[2]
      end
    end
  end
end
