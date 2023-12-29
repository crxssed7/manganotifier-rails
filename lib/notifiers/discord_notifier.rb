# frozen_string_literal: true

module Notifiers
  class DiscordNotifier < Base
    private

    def body
      Rails.logger.info("Notifying Discord webhook")
      Rails.logger.info(image)
      Rails.logger.info(ActionMailer::Base.default_url_options)
      {
        'embeds': [
          {
            'title': "#{manga.name}",
            'description': "New chapter is available! \n#{manga.last_chapter}",
            'thumbnail': {
              'url': UrlHelpers.image_manga_url(manga)
            },
            'color': 28915
          }
        ]
      }
    end
  end
end
