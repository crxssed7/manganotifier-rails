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
        entries.each do |entry|
          anilist_id = entry[:media][:id]
          name = entry[:media][:title][:english] || entry[:media][:title][:romaji]
          manga = Manga.where(anilist_id:).first

          next if manga.nil?

          progress = entry[:progress].to_i
          latest = manga.latest_chapter_number.to_i
          if progress < latest
            content << "- #{name}: #{progress} / #{latest} (#{latest - progress} behind)\n"
          end
        end

        event.respond(content:)
      end
    end
  end
end
