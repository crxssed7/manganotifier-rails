class CreateJoinTableMangaNotifier < ActiveRecord::Migration[7.0]
  def change
    create_join_table :mangas, :notifiers do |t|
      # t.index [:manga_id, :notifier_id]
      # t.index [:notifier_id, :manga_id]
    end
  end
end
