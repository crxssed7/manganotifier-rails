# frozen_string_literal: true
require "net/http"
require "uri"

module Notifier
  class DiscordNotifier
    attr_accessor :manga

    def initialize(manga:)
      @manga = manga
    end

    def notify
      body = {
        'embeds': [
          {
            'title': "#{manga.name}",
            'description': "New chapter is available! \n#{manga.last_chapter}",
            'thumbnail': {
              'url': manga.image
            },
            'color': 28915
          }
        ]
      }
      
      uri = URI('https://discordapp.com/api/webhooks/897554074143162378/5jns6Y4wYjiC7fGBW3NZ3iVZXWkuQtBQSMHPd-90CiBlxaIweJTKZNUuCP2LjkzeCOaN')

      Net::HTTP.post uri, body.to_json, { 'Content-Type' => 'application/json' }
    end
  end
end