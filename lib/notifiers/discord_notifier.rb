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
              'url': manga.image
            },
            'color': 28915
          }
        ]
      }
    end

    def webhook_url = "https://discordapp.com/api/webhooks/897554074143162378/5jns6Y4wYjiC7fGBW3NZ3iVZXWkuQtBQSMHPd-90CiBlxaIweJTKZNUuCP2LjkzeCOaN"
  end
end
