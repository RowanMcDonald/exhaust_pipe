# frozen_string_literal: true

require_relative "lib/exhaust_pipe/version"

Gem::Specification.new do |spec|
  spec.name          = "exhaust_pipe"
  spec.version       = ExhaustPipe::VERSION
  spec.authors       = ["RowanMcDonald"]
  spec.email         = ["rowjaim@gmail.com"]

  spec.summary       = "A helper library for managing tailwind class lists"
  spec.homepage      = "https://github.com/RowanMcDonald/exhaust_pipe"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage + "blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]
end
