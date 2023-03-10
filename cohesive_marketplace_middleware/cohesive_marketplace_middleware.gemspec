# frozen_string_literal: true

require_relative "lib/cohesive_marketplace_middleware/version"

Gem::Specification.new do |spec|
  spec.name = "cohesive_marketplace_middleware"
  spec.version = CohesiveMarketplaceMiddleware::VERSION
  spec.authors = ["Chinmay Relkar"]
  spec.email = ["chinmay@cohesive.so"]

  spec.summary = "Cohesive Marketplace Middleware"
  spec.description = "Gem for Cohesive Marketplace Middleware, currently includes AuthMiddleware"
  spec.homepage = "https://github.com/getcohesive/marketplace_sdk_ruby/cohesive_marketplace_middleware"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/getcohesive/marketplace_sdk_ruby/tree/main/cohesive_marketplace_middleware"
  spec.metadata["changelog_uri"] = "https://github.com/getcohesive/marketplace_sdk_ruby/tree/main/cohesive_marketplace_middleware/CHANGELOG.md"

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

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_runtime_dependency 'jwt', '~> 1.5', '>= 1.5.0'
  spec.add_runtime_dependency 'cohesive_marketplace_sdk', '~> 0.1.1', '>= 0.1.1'
  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
