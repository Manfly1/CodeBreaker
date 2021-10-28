# frozen_string_literal: true

RSpec.describe Codebreaker::Validation do
  subject(:validator) { class_with_validation.new }

  let(:class_with_validation) { Class.new { include Codebreaker::Validation } }

  describe '#valid_class?' do
    it 'returns true if class is valid' do
      expect(validator).to be_valid_class(String, 'abc')
    end

    it 'returns false if class is not valid' do
      expect(validator).not_to be_valid_class(String, 1)
    end
  end

  describe '#valid_non_empty_string?' do
    it 'returns true if string is not empty' do
      expect(validator).to be_valid_non_empty_string('abc')
    end

    it 'returns true if string is empty' do
      expect(validator).not_to be_valid_non_empty_string('')
    end
  end

  describe '#valid_positive_integer?' do
    it 'returns true if integer is greater than 0' do
      expect(validator).to be_valid_positive_integer(1)
    end

    it 'returns false if integer is not greater than 0' do
      expect(validator).not_to be_valid_positive_integer(0)
    end
  end

  describe '#valid_non_negative_integer?' do
    it 'returns true if integer is greater than or equal 0' do
      expect(validator).to be_valid_non_negative_integer(0)
    end

    it 'returns false if integer is not greater than or equal 0' do
      expect(validator).not_to be_valid_non_negative_integer(-1)
    end
  end

  describe '#valid_string_min_length?' do
    it 'returns true if string minimal length is greater than or equal passed number' do
      expect(validator).not_to be_valid_string_min_length('aaa', 2)
    end

    it 'returns false if string minimal length is not greater than or equal passed number' do
      expect(validator).to be_valid_string_min_length('aaa', 4)
    end
  end

  describe '#valid_string_max_length?' do
    it 'returns true if string maximal length is less than or equal passed number' do
      expect(validator).not_to be_valid_string_max_length('aaa', 4)
    end

    it 'returns false if string maximal length is not less than or equal passed number' do
      expect(validator).to be_valid_string_max_length('aaa', 2)
    end
  end

  describe '#valid_only_numeric_string?' do
    it 'returns true if string contains only digits' do
      expect(validator).to be_valid_only_numeric_string('1234')
    end

    it 'returns false if string contains other characters' do
      expect(validator).not_to be_valid_only_numeric_string('ad21a')
    end
  end

  describe '#valid_range?' do
    it 'returns true if all array elements are covered by range' do
      expect(validator).to be_valid_range((1..6), [1, 2, 3, 4, 5, 6])
    end

    it 'returns false if any of array elements is not covered by range' do
      expect(validator).not_to be_valid_range((1..6), [0, 1, 2, 3, 4, 5, 6, 7])
    end
  end
end
