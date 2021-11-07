# frozen_string_literal: true

RSpec.describe Codebreaker::CodeMatcher do
  context 'when testing matching the entered code to the created code' do
    [
      ['5179', '2222', ''],
      ['7253', '1113', '+'],
      ['6881', '2666', '-'],
      ['8275', '1256', '+-'],
      ['2667', '1661', '++'],
      ['2516', '6143', '--'],
      ['1239', '1235', '+++'],
      ['1274', '1248', '++-'],
      ['5143', '5413', '++--'],
      ['5634', '3456', '----'],
      ['1234', '1234', '++++']
    ].each do |value|
      it "tests that #{value.first} equals to #{value.last}" do
        expect(subject.secret_code(value[1], value[0])).to eq value.last
      end
    end
  end
end
