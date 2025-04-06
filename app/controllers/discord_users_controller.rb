class DiscordUsersController < ApplicationController
  def index
    @data = DiscordUser.all.map do |discord_user|
      {
        discord_user:,
        catch_up: discord_user.catch_up
      }
    end
  end
end
