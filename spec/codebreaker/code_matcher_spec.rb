# frozen_string_literal: true

RSpec.describe Codebreaker::CodeMatcher do
  describe '#valid?' do
    let(:valid_secret_code) { [1, 2, 3, 4] }
    let(:valid_guess_code) { [1, 2, 3, 4] }
    let(:invalid_secret_code) { 1 }
    let(:invalid_guess_code) { -1 }

    it 'returns true if instance is valid' do
      valid_matcher = described_class.new(valid_secret_code, valid_guess_code)
      expect(valid_matcher)
    end
    it 'returns false if instance is not valid' do
      invalid_matcher = described_class.new(invalid_secret_code, invalid_guess_code)
      expect(invalid_matcher)
    end
  end

  describe '#match_codes' do
    [
      [[5, 1, 7, 9], [2, 2, 2, 2], ''],
      [[7, 2, 5, 3], [1, 1, 1, 3], '+'],
      [[6, 8, 8, 1], [2, 6, 6, 6], '-'],
      [[8, 2, 7, 5], [1, 2, 5, 6], '+-'],
      [[2, 6, 6, 7], [1, 6, 6, 1], '++'],
      [[2, 5, 1, 6], [6, 1, 4, 3], '--'],
      [[1, 2, 3, 9], [1, 2, 3, 5], '+++'],
      [[1, 2, 7, 4], [1, 2, 4, 8], '++-'],
      [[5, 1, 4, 3], [5, 4, 1, 3], '++--'],
      [[5, 6, 3, 4], [3, 4, 5, 6], '----'],
      [[1, 2, 3, 4], [1, 2, 3, 4], '++++']
    ].each do |item|
      it 'returns correct result depends on input' do
        guess = described_class.new(item[0], item[1])
        expect(guess.match_codes).to eq item[2]
      end
    end
  end

  describe '#codes_match?' do
    let(:code) { [1, 2, 3, 4] }
    let(:guess) { [1, 2, 3, 4] }
    let(:wrong_guess) { [1, 2, 3, 1] }

    it 'returns true if codes exactly match (++++)' do
      matcher = described_class.new(code, guess)
      expect(matcher).to be_codes_match
    end

    it 'returns false if codes do not exactly match' do
      matcher = described_class.new(code, wrong_guess)
      expect(matcher).not_to be_codes_match
    end
  end
end
