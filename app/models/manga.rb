class Manga < ApplicationRecord
  SOURCES = {
    "Mangapill" => Sources::Mangapill,
    "Mangareader" => Sources::Mangareader,
    "Mangasee" => Sources::Mangasee
  }

  SOURCE_COLOURS = {
    "Mangapill" => "#0070f3",
    "Mangareader" => "#5f25a6",
    "Mangasee" => "#6589BF"
  }
  DEFAULT_COLOUR = "#ff6961"

  validates :external_id, presence: true, uniqueness: { scope: :source }
  validates_inclusion_of :source, in: SOURCES.keys, allow_nil: false, allow_blank: false

  has_and_belongs_to_many :notifiers

  def source_instance
    SOURCES[source].new(manga: self)
  end

  def refresh
    Rails.logger.info("M_HOST: #{Rails.application.routes.default_url_options[:host]}")
    Rails.logger.info("M_PROTOCOL: #{Rails.application.routes.default_url_options[:protocol]}")
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
end
