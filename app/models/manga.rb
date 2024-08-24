class Manga < ApplicationRecord
  SOURCES = {
    "Mangapill" => Sources::Mangapill,
    "Mangareader" => Sources::Mangareader,
    "Mangasee" => Sources::Mangasee,
    "Mangadex" => Sources::Mangadex
  }

  SOURCE_COLOURS = {
    "Mangapill" => "#0070f3",
    "Mangareader" => "#5f25a6",
    "Mangasee" => "#6589BF",
    "Mangadex" => "#FF6740"
  }
  DEFAULT_COLOUR = "#ff6961"

  validates :external_id, presence: true, uniqueness: {scope: :source}
  validates_presence_of :chapter_number_regex
  validates_inclusion_of :source, in: SOURCES.keys, allow_nil: false, allow_blank: false

  has_and_belongs_to_many :notifiers

  def source_instance
    SOURCES[source].new(manga: self)
  end

  def refresh
    if source_instance.refresh
      notifiers.each do |notifier|
        notifier.notifier_instance(manga: self).notify
      end
    end
  end

  def hex_colour_code
    SOURCE_COLOURS[source].presence || DEFAULT_COLOUR
  end

  def decimal_colour_code
    hex_colour_code.sub("#", "").hex
  end

  def latest_chapter_number
    regex = Regexp.new(chapter_number_regex)
    if (match = last_chapter.match(regex))
      match[1]
    end
  end
end
