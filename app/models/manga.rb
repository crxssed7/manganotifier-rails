class Manga < ApplicationRecord
  SOURCES = {
    "Mangapill" => Sources::Mangapill,
    "Mangareader" => Sources::Mangareader
  }

  validates :external_id, presence: true, uniqueness: { scope: :source }
  validates_inclusion_of :source, in: SOURCES.keys, allow_nil: false, allow_blank: false

  def source_instance
    SOURCES[source].new(manga: self)
  end
end
