# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_12_23_183037) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "mangas", force: :cascade do |t|
    t.string "name"
    t.string "external_id"
    t.string "last_chapter"
    t.string "source"
    t.string "image"
    t.datetime "last_refreshed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_id", "source"], name: "index_mangas_on_external_id_and_source", unique: true
  end

  create_table "mangas_notifiers", id: false, force: :cascade do |t|
    t.bigint "manga_id", null: false
    t.bigint "notifier_id", null: false
  end

  create_table "notifiers", force: :cascade do |t|
    t.string "name"
    t.string "webhook_url"
    t.string "notifier_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
