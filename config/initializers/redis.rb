class RedisSingleton
  include Singleton

  def client
    @client ||= Redis.new(url: ENV.fetch("REDIS_URL", "redis://127.0.0.1:6379/0"), password: ENV.fetch("REDIS_PASSWORD", nil))
  end
end
