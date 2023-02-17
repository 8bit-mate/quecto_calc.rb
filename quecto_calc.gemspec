# frozen_string_literal: true

require_relative "lib/quecto_calc/version"

Gem::Specification.new do |spec|
  spec.name          = "quecto_calc"
  spec.version       = QuectoCalc::VERSION
  spec.authors       = ["Mate"]
  #spec.email         = ["mate@example.com"]

  spec.summary       = "A very simple calculator."
  spec.description   = "Evaluates primitive arithmetic expressions represented in a text form."
  spec.homepage      = "https://github.com/8bit-mate/quecto_calc.rb/"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 3.0.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org/"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/8bit-mate/quecto_calc.rb/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
