# frozen_string_literal: true

module Notifiers
  class DiscordNotifier < Base
    private

    def body
      Rails.logger.info("Notifying Discord webhook")
      Rails.logger.info("N_HOST: #{Rails.application.routes.default_url_options[:host]}")
      Rails.logger.info("N_PROTOCOL: #{Rails.application.routes.default_url_options[:protocol]}")
      {
        'embeds': [
          {
            'title': "#{manga.name}",
            'description': "New chapter is available! \n#{manga.last_chapter}",
            'thumbnail': {
              'url': Rails.application.routes.url_helpers.image_manga_url(manga)
            },
            'color': 28915
          }
        ]
      }
    end
  end
end
