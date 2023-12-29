# frozen_string_literal: true

module Notifiers
  class DiscordNotifier < Base
    private

    def body
      Rails.logger.info("Notifying Discord webhook")
      Rails.logger.info(image_url)
      {
        'embeds': [
          {
            'title': "#{manga.name}",
            'description': "New chapter is available! \n#{manga.last_chapter}",
            'thumbnail': {
              'url': image_url
            },
            'color': 28915
          }
        ]
      }
    end
  end
end
