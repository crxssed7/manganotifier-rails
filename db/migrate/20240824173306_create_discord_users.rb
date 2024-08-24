class CreateDiscordUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :discord_users do |t|
      t.string :discord_id, null: false, blank: false, unique: true
      t.string :anilist, null: false, blank: false

      t.timestamps
    end
  end
end
