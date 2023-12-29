class Notifier < ApplicationRecord
  NOTIFIERS = {
    "Discord" => Notifiers::DiscordNotifier
  }

  has_and_belongs_to_many :mangas

  validates_inclusion_of :notifier_type, in: NOTIFIERS.keys, allow_nil: false, allow_blank: false

  def to_s = name

  def notifier_instance(manga:)
    NOTIFIERS[notifier_type].new(manga:, notifier: self)
  end
end
