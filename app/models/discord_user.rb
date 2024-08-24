class DiscordUser < ApplicationRecord
  validates_presence_of :discord_id, :anilist
  validates_uniqueness_of :discord_id
end
