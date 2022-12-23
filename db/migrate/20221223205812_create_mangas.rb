class CreateMangas < ActiveRecord::Migration[7.0]
  def change
    create_table :mangas do |t|
      t.string :name
      t.string :external_id
      t.string :last_chapter
      t.string :source
      t.string :image
      t.datetime :last_refreshed

      t.timestamps
    end
  end
end
