# frozen_string_literal: true

module Notifiers
  class DiscordNotifier < Base
    private

    def body
      Rails.logger.info("Notifying Discord webhook")
      Rails.logger.info("N_HOST: #{Rails.application.routes.default_url_options[:host]}")
      Rails.logger.info("N_PROTOCOL: #{Rails.application.routes.default_url_options[:protocol]}")
      # Rails.application.routes.url_helpers.image_manga_url(manga)
      {
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
    end
  end
end
