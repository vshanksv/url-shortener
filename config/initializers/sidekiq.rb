Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch("REDIS_URL", "redis://127.0.0.1:6379/1"), password: ENV.fetch("REDIS_PASSWORD", nil) }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch("REDIS_URL", "redis://127.0.0.1:6379/1"), password: ENV.fetch("REDIS_PASSWORD", nil) }
end
