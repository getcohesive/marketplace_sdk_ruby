cd cohesive_marketplace_sdk
bundle update
gem build cohesive_marketplace_sdk.gemspec
gem install cohesive_marketplace_sdk-0.1.1.gem
gem push cohesive_marketplace_sdk-0.1.1.gem
cd ..
cd cohesive_marketplace_middleware
bundle update
gem build cohesive_marketplace_middleware.gemspec
gem install cohesive_marketplace_middleware-0.1.3.gem
gem push cohesive_marketplace_middleware-0.1.3.gem
cd ..
