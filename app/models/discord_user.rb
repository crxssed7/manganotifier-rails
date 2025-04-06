class DiscordUser < ApplicationRecord
  validates_presence_of :discord_id, :anilist
  validates_uniqueness_of :discord_id

  def catch_up
    query = Anilist::Query::MediaListCollection.new(self.anilist, "CURRENT")
    json = Anilist::Request.send(query)

    return "There was an issue contacting the AniList API. Please try again later." if json.nil?

    list = json[:data][:MediaListCollection][:lists]&.first
    return "Could not find list on AniList." if list.nil?

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

    return content
  end
end
