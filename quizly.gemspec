# frozen_string_literal: true

require_relative "lib/quizly/version"

Gem::Specification.new do |spec|
  spec.name = "quizly"
  spec.version = Quizly::VERSION
  spec.authors = ["DreamVenerable"]
  spec.email = ["114648602+DreamVenerable@users.noreply.github.com"]

  spec.summary = "Quizly is a Ruby gem for creating and managing quizzes."
  spec.description = "Quizly provides a flexible and easy-to-use framework for building interactive quizzes within Rails applications."

  spec.homepage = "https://github.com/DreamVenerable/quizly"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/DreamVenerable/quizly/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore .rspec spec/ .rubocop.yml])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "rails", ">= 8.1.0"

  # Encourage MFA for publishing
  spec.metadata["rubygems_mfa_required"] = "true"
  spec.metadata["documentation_uri"] = "https://github.com/DreamVenerable/quizly#readme"

  # No test dependencies

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
