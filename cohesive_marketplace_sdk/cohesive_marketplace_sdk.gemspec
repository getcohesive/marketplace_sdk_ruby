# frozen_string_literal: true

require_relative "lib/cohesive_marketplace_sdk/version"

Gem::Specification.new do |spec|
  spec.name = "cohesive_marketplace_sdk"
  spec.version = CohesiveMarketplaceSDK::VERSION
  spec.authors = ["chinmayrelkar"]
  spec.email = ["chinmay@cohesive.so"]

  spec.summary = "An SDK to build saas apps for the Cohesive Marketplace"
  spec.description = "An SDK to build saas apps for the Cohesive Marketplace"
  spec.homepage = "https://cohesive.so"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/getcohesive/marketplace_sdk_ruby/tree/main/cohesive_marketplace_sdk"
  spec.metadata["changelog_uri"] = "https://github.com/getcohesive/marketplace_sdk_ruby/tree/main/cohesive_marketplace_sdk/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
