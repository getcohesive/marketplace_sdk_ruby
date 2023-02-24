module CohesiveMarketplaceSDK
  class TokenValidationError < StandardError
    def initialize(msg = "Failed to validate user", exception_type = "cohesive_sdk_error")
      @exception_type = exception_type
      super(msg)
    end
  end

  class TokenEmptyError < StandardError
    def initialize(msg = "User token empty", exception_type = "cohesive_sdk_error")
      @exception_type = exception_type
      super(msg)
    end
  end

  class TokenExpired < StandardError
    def initialize(msg = "User token expired", exception_type = "cohesive_sdk_error")
      @exception_type = exception_type
      super(msg)
    end
  end
end
