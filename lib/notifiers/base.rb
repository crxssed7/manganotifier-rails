# frozen_string_literal: true

module Notifiers
  class Base
    attr_reader :manga

    def initialize(manga:)
      @manga = manga
    end

    def notify
      uri = URI(webhook_url)
      Net::HTTP.post uri, body.to_json, { 'Content-Type' => 'application/json' }
    end

    private

    def body
      raise "Implement in subclass"
    end

    def webhook_url
      raise "Implement in subclass"
    end
  end
end
