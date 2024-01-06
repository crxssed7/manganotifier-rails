class AddActiveToManga < ActiveRecord::Migration[7.0]
  def change
    add_column :mangas, :active, :boolean, default: true
  end
end
