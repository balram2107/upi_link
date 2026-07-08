# frozen_string_literal: true

require_relative "lib/upi_link/version"

Gem::Specification.new do |spec|
  spec.name = "upi_link"
  spec.version = UpiLink::VERSION
  spec.authors = ["balram"]
  spec.email = ["developer.balram@gmail.com"]

  spec.summary = "Generate UPI payment links and QR codes for Ruby/Rails apps"
  spec.description = "Lightweight gem to build UPI deep links, validate VPAs, and generate QR codes — no payment gateway, no merchant account, just link generation for direct P2P-style UPI collection."

  spec.homepage = "https://github.com/balram2107/upi_link"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["source_code_uri"] = "https://github.com/balram2107/upi_link"
  spec.metadata["changelog_uri"] = "https://github.com/balram2107/upi_link/blob/main/CHANGELOG.md"
  spec.metadata["documentation_uri"] = "https://github.com/balram2107/upi_link/blob/main/README.md"

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
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "rqrcode", "~> 2.2"
  spec.add_dependency "chunky_png", "~> 1.4"  # needed for PNG support in rqrcode

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
