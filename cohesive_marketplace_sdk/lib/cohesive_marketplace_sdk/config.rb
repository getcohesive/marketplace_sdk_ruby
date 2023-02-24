require "singleton"

module CohesiveMarketplaceSDK
  class Config
    include Singleton

    private_class_method :new

    def initialize
      @cohesive_base_url = ENV["COHESIVE_BASE_URL"]
      @cohesive_api_key = ENV["COHESIVE_API_KEY"]
      @cohesive_app_id = ENV["COHESIVE_APP_ID"]
      @cohesive_app_secret = ENV["COHESIVE_APP_SECRET"]

      begin
        # Ensure all required environment variables are set
        raise ArgumentError, "Environment variable 'COHESIVE_BASE_URL' is empty or nil" if @cohesive_base_url.nil? || @cohesive_base_url.empty?
        raise ArgumentError, "Environment variable 'COHESIVE_API_KEY' is empty or nil" if @cohesive_api_key.nil? || @cohesive_api_key.empty?
        raise ArgumentError, "Environment variable 'COHESIVE_APP_ID' is empty or nil" if @cohesive_app_id.nil? || @cohesive_app_id.empty?
        raise ArgumentError, "Environment variable 'COHESIVE_APP_SECRET' is empty or nil" if @cohesive_app_secret.nil? || @cohesive_app_secret.empty?
      rescue ArgumentError => e
        raise "Fatal error: #{e.message}"
      end
    end
    attr_reader :cohesive_base_url
    attr_reader :cohesive_api_key
    attr_reader :cohesive_app_id
    attr_reader :cohesive_app_secret
  end

  def self.config
    @config ||= Config.instance
  end
end
