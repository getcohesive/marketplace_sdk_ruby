cd cohesive_marketplace_sdk
gem build cohesive_marketplace_sdk.gemspec
gem install cohesive_marketplace_sdk-0.1.0.gem
gem push cohesive_marketplace_sdk-0.1.0.gem
cd ..
cd cohesive_marketplace_middleware
gem build cohesive_marketplace_middleware.gemspec
gem install cohesive_marketplace_middleware-0.1.1.gem
gem push cohesive_marketplace_sdk-0.1.0.gem
cd ..
