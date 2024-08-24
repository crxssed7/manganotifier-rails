class AddChapterNumberRegexToManga < ActiveRecord::Migration[7.0]
  def change
    add_column :mangas, :chapter_number_regex, :string, null: false, default: "^Chapter (\\d+)"
    add_column :mangas, :anilist_id, :integer
  end
end
