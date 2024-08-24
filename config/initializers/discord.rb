Rails.application.config.after_initialize do
  Thread.new do
    Discord::Bot.new.run
  end
end
