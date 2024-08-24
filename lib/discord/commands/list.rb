module Discord
  module Commands
    class List < Command
      def name = :list

      def description = "View a list from your AniList account"

      private

      def register_application_command(cmd)
        choices = {
          "Reading" => "CURRENT",
          "Plan to read" => "PLANNING",
          "Completed" => "COMPLETED",
          "Rereading" => "REPEATING",
          "Paused" => "PAUSED",
          "Dropped" => "DROPPED"
        }
        cmd.string("list_name", "The list you want to view. Defaults to 'Reading'.", choices:)
      end

      def handle_event(event)
        discord_user = get_discord_user(event)
        if discord_user.nil?
          event.respond(content: "You do not have an AniList account specified. Please run /setup to assign your account.")
          return
        end

        status = event.options["list_name"] || "CURRENT"

        query = Anilist::Query::MediaListCollection.new(discord_user.anilist, status)
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

        content = "**Your #{status.downcase} list:**\n"
        list[:entries].each do |entry|
          title = entry[:media][:title][:english] || entry[:media][:title][:romaji]
          progress = entry[:progress]
          chapter_count = entry[:media][:chapters]
          content << "- **#{title}**: #{progress} / #{chapter_count}\n"
        end

        event.respond(content: content)
      end
    end
  end
end
