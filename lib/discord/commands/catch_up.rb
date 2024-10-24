module Discord
  module Commands
    class CatchUp < Command
      def name = :catchup

      def description = "View all the manga that you need to catch up on"

      private

      def register_application_command(cmd)
      end

      def handle_event(event)
        discord_user = get_discord_user(event)
        if discord_user.nil?
          event.respond(content: "You do not have an AniList account specified. Please run /setup to assign your account.")
          return
        end

        query = Anilist::Query::MediaListCollection.new(discord_user.anilist, "CURRENT")
        json = Anilist::Request.send(query)

        if json.nil?
          event.respond(content: "There was an issue contacting the AniList API. Please try again later.")
          return
        end

        list = json[:data][:MediaListCollection][:lists]&.first
        if list.nil?
          event.respond(content: "Could not find list on AniList.")
          return
        end

        content = "**You need to catch up on:**\n"
        entries = list[:entries]
        results = []
        entries.each do |entry|
          anilist_id = entry[:media][:id]
          name = entry[:media][:title][:english] || entry[:media][:title][:romaji]
          manga = Manga.where(anilist_id:).first
          progress = entry[:progress].to_i

          latest = entry[:media][:chapters] || manga&.latest_chapter_number

          next if latest.nil?

          if progress < latest.to_i
            results.append({
              name:,
              progress:,
              latest:,
              amount_left: latest.to_i - progress
            })
          end
        end

        text = results.sort_by { _1[:amount_left] }.map { "- #{_1[:name]}: #{_1[:progress]} / #{_1[:latest]} (#{_1[:amount_left]} behind)" }.join("\n")
        content << text

        event.respond(content:)
      end
    end
  end
end
