# frozen_string_literal: true

module Notifiers
  class Base
    include MangasHelper

    attr_reader :manga, :notifier

    def initialize(manga:, notifier:)
      @manga = manga
      @notifier = notifier
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
