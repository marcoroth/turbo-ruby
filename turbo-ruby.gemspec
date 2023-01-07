# frozen_string_literal: true

require_relative "lib/turbo/ruby/version"

Gem::Specification.new do |spec|
  spec.name = "turbo-ruby"
  spec.version = Turbo::Ruby::VERSION
  spec.authors = ["Marco Roth"]
  spec.email = ["marco.roth@intergga.ch"]

  spec.summary = "Turbo helpers without the requirement for Rails"
  spec.description = spec.summary
  spec.homepage = "https://github.com/marcoroth/turbo-ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/marcoroth/turbo-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/marcoroth/turbo-ruby"
  spec.metadata["rubygems_mfa_required"] = "true"
  
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end

  spec.files = Dir["{app,lib}/**/*", "LICENSE", "README.md"]

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "phlex", "~> 1.0"
  spec.add_dependency "phlex-rails", "~> 0.4"
end
