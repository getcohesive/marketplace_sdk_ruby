require "cohesive_marketplace_middleware"

module AuthMiddleware
  class Railtie < Rails::Railtie
    initializer "cohesive_marketplace_middleware.configure_rails_initialization" do |app|
      app.middleware.use AuthMiddleware
      app.middleware.use CookieAuthMiddleware
    end
  end
end
