module CohesiveMarketplaceSDK
  AuthDetails = Struct.new(
    :user_id,
    :user_name,
    :user_email,
    :role,
    :workspace_id,
    :workspace_name,
    :instance_id,
    :current_period_started_at,
    :current_period_ends_at,
    :is_in_trial,
    :trial_items_count,
    keyword_init: true
  ) do
    attr_reader :user_id, :user_name, :user_email, :role, :workspace_id, :workspace_name,
      :instance_id, :current_period_started_at, :current_period_ends_at, :is_in_trial,
      :trial_items_count

    def initialize(*args)
      super
      freeze
    end
  end
end
