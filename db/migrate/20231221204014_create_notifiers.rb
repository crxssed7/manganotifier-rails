class CreateNotifiers < ActiveRecord::Migration[7.0]
  def change
    create_table :notifiers do |t|
      t.string :name
      t.string :webhook_url
      t.string :notifier_type

      t.timestamps
    end
  end
end
