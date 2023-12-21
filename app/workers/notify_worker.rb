class NotifyWorker
  include Sidekiq::Worker

  def perform
    Manga.where(last_refreshed: ..1.hour.ago).each do |manga|
      # Send Notification
      # For now, lets just hardcode one notifier
      if manga.source_instance.refresh
        Notifiers::DiscordNotifier.new(manga:).notify
      end
    end
  end
end
