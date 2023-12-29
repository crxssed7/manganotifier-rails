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
              'url': image_url_for(manga:)
            },
            'color': 28915
          }
        ]
      }
    end
  end
end
