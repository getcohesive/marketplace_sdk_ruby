# frozen_string_literal: true

require_relative "cohesive_marketplace_middleware/version"
require "cohesive_marketplace_sdk"

AUTH_DETAILS_ENV_KEY = "auth_details"
COHESIVE_MIDDLEWARE_IGNORE_PATH_PREFIX = "COHESIVE_MIDDLEWARE_IGNORE_PATH_PREFIX"
COHESIVE_MIDDLEWARE_LOGIN_PATH = "COHESIVE_MIDDLEWARE_LOGIN_PATH"
COHESIVE_MIDDLEWARE_LOGIN_PATH_DEFAULT = "/cohesive_login"

module CohesiveMarketplaceMiddleware
  def self.get_cohesive_auth_details(env)
    env[AUTH_DETAILS_ENV_KEY]
  end

  def self.collect_ignore_paths
    # Get the path prefixes to ignore from an environment variable.
    ignore_path_prefix_string = ENV[COHESIVE_MIDDLEWARE_IGNORE_PATH_PREFIX]
    result = []
    if ignore_path_prefix_string && ignore_path_prefix_string != "nil"
      # Split the prefixes into an array.
      result = ignore_path_prefix_string.split(",")
    end

    # Output some information for debugging.
    puts("Cohesive middleware ignoring paths: ", result)
    result
  end

  class AuthMiddleware
    # Initializes a new instance of the middleware.
    #
    # @param app [Object] The application object.
    #
    # @return [void]
    def initialize(app)
      @app = app
      @ignore_paths = CohesiveMarketplaceMiddleware.collect_ignore_paths
    end

    def call(env)
      # Check if the current path should be ignored.
      if !(@ignore_paths.any? { |prefix| env["REQUEST_PATH"] && env["REQUEST_PATH"].start_with?(prefix) })
        authorization_header = env["HTTP_AUTHORIZATION"]
        if authorization_header&.start_with?("Bearer ")
          token = authorization_header.sub("Bearer ", "")
          begin
            env[AUTH_DETAILS_ENV_KEY] = CohesiveMarketplaceSDK.validate_jwt token
          rescue => exception
            puts exception
            return [401, {"Content-Type" => "text/plain"}, [exception.message]]
          end
        else
          return [401, {"Content-Type" => "text/plain"}, ["No Token in auth header"]]
        end
      end
      @app.call(env)
    end
  end

  class CookieAuthMiddleware
    # Initializes a new instance of the middleware.
    #
    # @param app [Object] The application object.
    #
    # @return [void]
    def initialize(app)
      @app = app
      @ignore_paths = CohesiveMarketplaceMiddleware.collect_ignore_paths

      # Get the login redirect URI from an environment variable.
      @redirect_uri = ENV[COHESIVE_MIDDLEWARE_LOGIN_PATH]
      # Set a default URI if the environment variable is not set.
      if !@redirect_uri || @redirect_uri == ""
        @redirect_uri = COHESIVE_MIDDLEWARE_LOGIN_PATH_DEFAULT
      end

      # Add the login redirect URI to the list of ignored paths.
      @ignore_paths = @ignore_paths.append(@redirect_uri)

      # Output some information for debugging.
      puts("Cohesive middleware login redirect: ", @redirect_uri)
    end

    # Processes a request and authenticates the user if necessary.
    #
    # @param env [Hash] The Rack environment hash.
    #
    # @return [Array] A Rack-compatible response triplet.
    def call(env)
      # Check if the current path should be ignored.
      if !(@ignore_paths.any? { |prefix| env["REQUEST_PATH"] && prefix && env["REQUEST_PATH"].start_with?(prefix) })
        # Create a new request object.
        request = ActionDispatch::Request.new(env)
        # Get the authentication token from the cookie.
        token = request.cookie_jar[:chAppToken]
        if token
          begin
            # Validate the JWT token and store the result in the environment hash.
            env[AUTH_DETAILS_ENV_KEY] = CohesiveMarketplaceSDK.validate_jwt token
          rescue => exception
            # Return a 401 Unauthorized response if the token is invalid.
            puts exception
            return [401, {"Content-Type" => "text/plain"}, [exception.message]]
          end
        else
          # Redirect the user to the login page if the token is missing.
          return [301, {"Location" => COHESIVE_MIDDLEWARE_LOGIN_PATH_DEFAULT, "Content-Type" => "text/plain"}, ["token not in cookie"]]
        end
      end
      # Call the next middleware or application in the chain.
      @app.call(env)
    end
  end
end
