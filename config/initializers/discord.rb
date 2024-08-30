Rails.application.config.after_initialize do
  if defined?(Rails::Server) || File.basename($PROGRAM_NAME).include?("puma")
    Thread.new do
      Discord::Bot.new.run
    end
  end
end
