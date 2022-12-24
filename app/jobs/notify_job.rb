class NotifyJob < ApplicationJob
  queue_as :default

  def perform
    Manga.where(last_refreshed: ..1.hour.ago).each do |manga|
      # Send Notification
      # For now, lets just hardcode one notifier
      Notifier::DiscordNotifier.new(manga: manga).notify
    end
  end
end
