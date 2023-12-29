# frozen_string_literal: true

module Notifiers
  class DiscordNotifier < Base
    private

    def body
      image = image_url_for(manga:)
      Rails.logger.info("Notifying Discord webhook")
      Rails.logger.info(image)
      {
        'embeds': [
          {
            'title': "#{manga.name}",
            'description': "New chapter is available! \n#{manga.last_chapter}",
            'thumbnail': {
              'url': image
            },
            'color': 28915
          }
        ]
      }
    end
  end
end
