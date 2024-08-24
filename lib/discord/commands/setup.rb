module Discord
  module Commands
    class Setup < Command
      def name = :setup

      def description = "Assign an AniList account to your Discord profile"

      private

      def register_application_command(cmd)
        cmd.string("anilist", "Your AniList username", required: true)
      end

      def handle_event(event)
        # TODO: Actually send a request to AniList to check if this user exists.
        discord_user = DiscordUser.find_or_initialize_by(discord_id: event.user.id)
        discord_user.anilist = event.options["anilist"]

        if discord_user.save
          event.respond(content: "Your AniList username has been successfully saved as #{discord_user.anilist}")
        else
          event.respond(content: "Could not save your AniList username. Double check that you have spelled your name correctly. Your AniList account may also need to be set to public.")
        end
      end
    end
  end
end
