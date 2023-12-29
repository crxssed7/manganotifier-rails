# frozen_string_literal: true

module Notifiers
  class Base
    attr_reader :manga, :notifier, :image_url

    def initialize(manga:, notifier:, image_url:)
      @manga = manga
      @notifier = notifier
      @image_url = image_url
    end

    def notify
      uri = URI(notifier.webhook_url)
      Net::HTTP.post uri, body.to_json, { 'Content-Type' => 'application/json' }
    end

    private

    def body
      raise "Implement in subclass"
    end
  end
end
