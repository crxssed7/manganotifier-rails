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

        content = discord_user.catch_up
        event.respond(content:)
      end
    end
  end
end
