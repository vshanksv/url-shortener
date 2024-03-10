class RateLimitingService
  include BaseService

  attr_reader :refresh_timespan, :blocking_timespan, :limit, :feature, :user

  def initialize(refresh_timespan, blocking_timespan, limit, feature = nil)
    @refresh_timespan = refresh_timespan
    @blocking_timespan = blocking_timespan
    @limit = limit
    @feature = feature
    @user = Current.user
  end

  def call
    # rate limit does not apply to admin users and anonymous users
    return success if user.blank? || user.admin?

    redis = RedisSingleton.instance.client
    usage_key = "#{feature}rate.limit.#{user.id}"
    block_key = "#{feature}lock.rate.limit.#{user.id}"

    begin
      if redis.exists?(block_key)
        raise RateLimitExceedError
      elsif redis.exists?(usage_key)
        request_number = redis.incr(usage_key)
        if request_number > limit
          redis.set(block_key, true, ex: blocking_timespan)
          raise RateLimitExceedError
        end
      else
        redis.set(usage_key, 1, ex: refresh_timespan)
      end

      success
    rescue RateLimitExceedError => e
      Rails.logger.error("User: #{user.id}, #{e.message}")
      failure(e.message)
    end
  end
end
