class RateLimitExceedError < StandardError
  def initialize(msg = "Rate limit exceeded")
    super(msg)
  end
end
