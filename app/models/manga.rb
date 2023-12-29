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
end
