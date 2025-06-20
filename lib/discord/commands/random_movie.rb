module Discord
  module Commands
    class RandomMovie < Command
      TRAKT_USERNAME = 'crxssed'
      LIST_SLUG = 'movie-nights'

      def name = :random_movie

      def description = "View all the manga that you need to catch up on"

      private

      def client_id = Rails.application.credentials.dig(:trakt_client_id)

      def register_application_command(cmd)
      end

      def handle_event(event)
        items = fetch_list
        item = pick_random_item(items)
        title = item['title']
        year = item['year'] || 'Unknown'
        type = item['type']
        slug = item['ids']['slug']
        poster = "https://#{item['images']['poster']&.first}"

        embed = Discordrb::Webhooks::Embed.new(
          title: "🎲 Random Movie",
          description: "We'll be watching **#{title} (#{year})**!",
          color: 0x00ffcc,
          url: "https://trakt.tv/#{type}/#{slug}",
          thumbnail: Discordrb::Webhooks::EmbedThumbnail.new(url: poster),
          footer: Discordrb::Webhooks::EmbedFooter.new(text: "Picked from your Trakt list"),
          timestamp: next_friday_10pm_bst
        )

        event.respond(embeds: [embed])
      rescue => e
        event.respond(content: "Error: #{e.message}")
      end

      def pick_random_item(items)
        if items.empty?
          puts "The list is empty."
          return
        end

        item = items.sample
        type = item['type']
        media = item[type]
        media['type'] = type
        return media
      end

      def fetch_list
        url = URI("https://api.trakt.tv/users/#{TRAKT_USERNAME}/lists/#{LIST_SLUG}/items?extended=images")

        request = Net::HTTP::Get.new(url)
        request['Content-Type'] = 'application/json'
        request['trakt-api-version'] = '2'
        request['trakt-api-key'] = client_id

        response = Net::HTTP.start(url.hostname, url.port, use_ssl: true) do |http|
          http.request(request)
        end

        raise "Error fetching list: #{response.code} - #{response.body}" unless response.code.to_i == 200

        JSON.parse(response.body)
      end


      def next_friday_10pm_bst
        # Get the current time in UTC
        now_utc = Time.now.utc

        # Define BST time zone (London handles daylight saving automatically)
        london_tz = TZInfo::Timezone.get('Europe/London')

        # Convert current time to London time
        now_london = london_tz.to_local(now_utc)

        # Calculate days to next Friday (wday 5)
        days_until_friday = (5 - now_london.wday) % 7
        days_until_friday = 7 if days_until_friday == 0 && now_london.hour >= 22

        # Get next Friday's date in London
        next_friday = now_london.to_date + days_until_friday

        # Set time to 22:00 (10 PM) in London time
        next_friday_10pm_london = Time.new(
          next_friday.year,
          next_friday.month,
          next_friday.day,
          22, 0, 0,
          london_tz.period_for_local(Time.new(next_friday.year, next_friday.month, next_friday.day, 22)).utc_total_offset
        )

        # Return in UTC so it works correctly in Discord
        next_friday_10pm_london.utc
      end
    end
  end
end
