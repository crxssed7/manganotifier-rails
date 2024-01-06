class NotifyWorker
  include Sidekiq::Worker

  def perform
    Manga.where(active: true, last_refreshed: ..30.minutes.ago).each do |manga|
      manga.refresh
    end
  end
end
