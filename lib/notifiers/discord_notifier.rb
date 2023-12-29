# frozen_string_literal: true

module Notifiers
  class DiscordNotifier < Base
    private

    def body
      {
        'embeds': [
          {
            'title': "#{manga.name}",
            'description': "New chapter is available! \n#{manga.last_chapter}",
            'thumbnail': {
              'url': Rails.application.routes.url_helpers.image_manga_url(manga, host: ENV["MANGA_NOTIFIER_HOST"] || "localhost")
            },
            'color': 28915
          }
        ]
      }
    end
  end
end
