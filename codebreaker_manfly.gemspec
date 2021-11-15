# frozen_string_literal: true

require_relative 'lib/codebreaker/version'

Gem::Specification.new do |spec|
  spec.name          = 'codebreaker_manfly'
  spec.version       = Codebreaker::VERSION
  spec.authors       = ['Andrii Ivaniuk']
  spec.email         = ['aivanuyk0@gmail.com']

  spec.summary       = 'Short summary, because RubyGems requires one.'
  spec.description   = 'Longer description or delete this line.'

  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.7.0'
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'faker'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.10'
  spec.add_development_dependency 'rubocop', '~> 1.7'
  spec.add_development_dependency 'simplecov'
end
