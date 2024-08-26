Rails.application.config.after_initialize do
  if defined?(Rails::Server)
    Thread.new do
      Discord::Bot.new.run
    end
  end
end
