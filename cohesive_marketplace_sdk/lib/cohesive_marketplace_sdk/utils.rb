require "jwt"
require_relative "config"
require_relative "errors"
require_relative "auth_details"

module CohesiveMarketplaceSDK
  def self.validate_jwt(jwt_token)
    if jwt_token.empty? || jwt_token.nil?
      raise TokenEmptyError.new
    end

    decoded_token = JWT.decode(jwt_token, config.cohesive_app_secret, true, {algorithm: "HS256"})
    payload = decoded_token[0]

    AuthDetails.new(
      user_id: payload["user_id"],
      user_name: payload["user_name"],
      user_email: payload["user_email"],
      role: payload["role"],
      workspace_id: payload["workspace_id"],
      workspace_name: payload["workspace_name"],
      instance_id: payload["instance_id"],
      current_period_started_at: payload["current_period_started_at"],
      current_period_ends_at: payload["current_period_ends_at"],
      is_in_trial: payload["is_in_trial"],
      trial_items_count: payload["trial_items_count"]
    )
  rescue JWT::DecodeError => err
    puts "failed to validate token:" + err.message
    raise TokenValidationError.new
  rescue JWT::ExpiredSignature
    raise TokenExpiredError.new
  end
end
