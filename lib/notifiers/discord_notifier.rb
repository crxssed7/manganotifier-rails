# frozen_string_literal: true

module Notifiers
  class DiscordNotifier < Base
    private

    def body
      {
        "embeds": [
          {
            "title": "#{manga.name}",
            "description": "New chapter is available! \n`#{manga.last_chapter}`",
            "thumbnail": {
              "url": Rails.application.routes.url_helpers.image_manga_url(manga)
            },
            "color": manga.decimal_colour_code
          }
        ]
      }
    end
  end
end
