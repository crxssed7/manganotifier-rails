class NotifyJob < ApplicationJob
  queue_as :default

  def perform
    Manga.where(last_refreshed: ..1.hour.ago).each do |manga|
      manga.refresh
    end
  end
end
