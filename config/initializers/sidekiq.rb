db = {
  "development" => 2,
  "production" => 2,
  # Avoid test runs interfering with development (15 is highest database index)
  "test" => 15
}.fetch(Rails.env.to_s)

sidekiq_config = {url: ENV.fetch("REDIS_URL", "redis://localhost:6379/2"), db: db}

Sidekiq.configure_server do |config|
  config.logger.level = :debug
  config.redis = sidekiq_config
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end

Sidekiq.default_job_options = {"backtrace" => true}

if Rails.env.test?
  Sidekiq.logger.level = Logger::WARN
end
