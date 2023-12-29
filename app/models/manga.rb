class Manga < ApplicationRecord
  SOURCES = {
    "Mangapill" => Sources::Mangapill,
    "Mangareader" => Sources::Mangareader,
    "Mangasee" => Sources::Mangasee
  }

  validates :external_id, presence: true, uniqueness: { scope: :source }
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

  private

  # TODO: Figure out why we can't use url helpers in the lib/ folder
  def image_url
    protocol = Rails.application.routes.default_url_options[:protocol]
    host = Rails.application.routes.default_url_options[:host]
    port = Rails.env.development? ? ":3000" : ""

    manga_image_path = Rails.application.routes.url_helpers.image_manga_path(self)

    "#{protocol}://#{host}#{port}#{manga_image_path}"
  end
end
