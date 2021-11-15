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
      it 'returns valid result' do
        secret_code, user_code, result = value

        expect(subject.match(user_code, secret_code)).to eq result
      end
    end
  end
end
