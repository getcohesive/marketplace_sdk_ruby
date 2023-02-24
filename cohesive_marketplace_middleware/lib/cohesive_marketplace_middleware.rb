# frozen_string_literal: true

require_relative "cohesive_marketplace_middleware/version"
require "cohesive_marketplace_sdk"

module CohesiveMarketplaceMiddleware
  class Error < StandardError; end

  class AuthMiddleware
    def initialize(app)
      @app = app
      puts @secret_key
    end

    def call(env)
      authorization_header = env["HTTP_AUTHORIZATION"]
      if authorization_header&.start_with?("Bearer ")
        token = authorization_header.sub("Bearer ", "")
        env["auth_details"] = CohesiveMarketplaceSDK.validate_jwt token
      else
        return [401, {"Content-Type" => "text/plain"}, ["No Token"]]
      end

      @app.call(env)
    end
  end
end
