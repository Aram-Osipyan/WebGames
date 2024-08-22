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

ActiveRecord::Schema[7.1].define(version: 2024_08_21_213901) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentication_lines", force: :cascade do |t|
    t.integer "user_id"
    t.string "code"
    t.boolean "active"
    t.datetime "active_until"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "day_words", force: :cascade do |t|
    t.string "word"
    t.datetime "active_until"
    t.boolean "active", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "external_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wordle_games", force: :cascade do |t|
    t.integer "user_id"
    t.jsonb "game_state"
    t.datetime "active_until"
    t.integer "day_word_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
