# frozen_string_literal: true

require_relative 'lib/validify_me/version'

Gem::Specification.new do |spec|
  spec.name = 'validify_me'
  spec.version = ValidifyMe::VERSION
  spec.authors = ['Jovan']
  spec.email = ['jovansr@protonmail.com']
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.summary = 'Gem for validating and serializing data'
  spec.homepage = 'https://github.com/Ckojo/validify_me'
  spec.required_ruby_version = '>= 3.0.2'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/Ckojo/validify_me'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
