module Discord
  module Commands
    class Command
      def initialize(bot, server_id: nil)
        @bot = bot
        @bot.register_application_command(name, description, server_id:) do |cmd|
          register_application_command(cmd)
        end
      end

      def register_command
        @bot.application_command(name) do |event|
          handle_event(event)
        end
      end

      def self.register_command(bot:, server_id: nil)
        new(bot, server_id:).register_command
      end

      def name = raise "Implement in subclass"

      def description = raise "Implement in subclass"

      private

      def register_application_command(cmd)
        raise "Implement in base class"
      end

      def handle_event(event)
        raise "Implement in base class"
      end

      def get_discord_user(event)
        DiscordUser.find_by(discord_id: event.user.id)
      end
    end
  end
end
