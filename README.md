# Codebreaker

Codebreaker is a logic game in which a code-breaker tries to break a secret code created by a code-maker. The code-maker, which will be played by the application we’re going to write, creates a secret code of four numbers between 1 and 6.

The code-breaker then gets some number of chances to break the code. In each turn, the code-breaker makes a guess of four numbers. The code-maker then marks the guess with up to four + and - signs.

A + indicates an exact match: one of the numbers in the guess is the same as one of the numbers in the secret code and in the same position.

A - indicates a number match: one of the numbers in the guess is the same as one of the numbers in the secret code but in a different position.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'codebreaker_manfly', '~> 0.1.0'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install codebreaker_manfly

## Usage

To use this game it should be installed in a console or web vesion of the game

Create an instance of the game:

game = Codebreacker::Game.new

During instantiation you can set matcher (object that will be used for guesses matching) and storage (object that will be used for storing scores).