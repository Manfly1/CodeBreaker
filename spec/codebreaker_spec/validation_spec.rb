# frozen_string_literal: true

RSpec.describe Codebreaker::Validation do
  subject(:validator) { class_with_validation.new }
  let(:class_with_validation) { Class.new { include Codebreaker::Validation } }

  describe '#valid_class?' do
    it 'returns true if class is valid' do
      expect(validator.valid_class?(String, 'abc')).to eq true
    end

    it 'returns false if class is not valid' do
      expect(validator.valid_class?(String, 1)).to eq false
    end
  end

  describe '#valid_non_empty_string?' do
    it 'returns true if string is not empty' do
      expect(validator.valid_non_empty_string?('abc')).to eq true
    end

    it 'returns true if string is empty' do
      expect(validator.valid_non_empty_string?('')).to eq false
    end
  end
  describe '#valid_positive_integer?' do
    it 'returns true if integer is greater than 0' do
      expect(validator.valid_positive_integer?(1)).to eq true
    end
    it 'returns false if integer is not greater than 0' do
      expect(validator.valid_positive_integer?(0)).to eq false
    end
  end
  describe '#valid_string_min_length?' do
    it 'returns true if string minimal length is greater than or equal passed number' do
      expect(validator.valid_string_min_length?('aaa', 2)).to eq true
    end

    it 'returns false if string minimal length is not greater than or equal passed number' do
      expect(validator.valid_string_min_length?('aaa', 4)).to eq false
    end
  end

  describe '#valid_string_max_length?' do
    it 'returns true if string maximal length is less than or equal passed number' do
      expect(validator.valid_string_max_length?('aaa', 4)).to eq true
    end

    it 'returns false if string maximal length is not less than or equal passed number' do
      expect(validator.valid_string_max_length?('aaa', 2)).to eq false
    end
  end

  describe '#valid_only_numeric_string?' do
    it 'returns true if string contains only digits' do
      expect(validator.valid_only_numeric_string?('1234')).to eq true
    end

    it 'returns false if string contains other characters' do
      expect(validator.valid_only_numeric_string?('1234asss')).to eq false
    end
  end

  describe '#valid_range?' do
    it 'returns true if all array elements are covered by range' do
      expect(validator.valid_range?((1..6), [1, 2, 3, 4, 5, 6])).to eq true
    end

    it 'returns false if any of array elements is not covered by range' do
      expect(validator.valid_range?((1..6), [0, 1, 2, 3, 4, 5, 6, 7])).to eq false
    end
  end
end
