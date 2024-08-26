module Discord
  class Bot
    def initialize
      @bot = Discordrb::Bot.new(
        token: Rails.application.credentials.dig(:bot_token),
        intents: [:server_messages]
      )

      register_commands
    end

    def self.run
      new.run
    end

    def run
      @bot.run
    end

    private

    def register_commands
      server_id = nil
      Commands::Setup.register_command(bot: @bot, server_id:)
      Commands::List.register_command(bot: @bot, server_id:)
      Commands::CatchUp.register_command(bot: @bot, server_id:)
    end
  end
end
