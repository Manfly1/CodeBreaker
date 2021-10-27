# frozen_string_literal: true

module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }

    before { game.start_new_game }

    describe '#generate_signs' do
      test_data =
        [
          ['5179', '2222', ''],
          ['7253', '1113', '+'],
          ['6881', '2666', '-'],
          ['8275', '1256', '+-'],
          ['2667', '1661', '++'],
          ['2516', '6143', '--'],
          ['1239', '1235', '+++'],
          ['1274', '1524', '++-'],
          ['5143', '5413', '++--'],
          ['5634', '3456', '----'],
          ['1234', '1234', '++++']
        ].each do |code, guess, expected|
          it "returnes #{expected} when generated code is #{code} and user code is #{guess}" do
            game.instance_variable_set(:@code, code)
            expect(game.generate_signs(guess)).to eq expected
          end
        end

      it 'attempts by 1' do
        expect { game.generate_signs('1111') }.to change(game.user, :attempts).by(-1)
      end

      end
  end
end
