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

ActiveRecord::Schema[7.1].define(version: 2025_08_20_094203) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "authentication_lines", force: :cascade do |t|
    t.integer "user_id"
    t.string "code"
    t.boolean "active"
    t.datetime "active_until"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cached_words", force: :cascade do |t|
    t.string "word"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["word"], name: "index_word_on_cached_words", unique: true
  end

  create_table "day_words", force: :cascade do |t|
    t.string "word"
    t.datetime "active_until"
    t.boolean "active", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quiz_games", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.jsonb "game_state"
    t.datetime "active_until"
    t.integer "score", default: 0
    t.integer "correct_answers", default: 0
    t.integer "total_questions", default: 10
    t.boolean "completed", default: false
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active_until"], name: "index_quiz_games_on_active_until"
    t.index ["completed"], name: "index_quiz_games_on_completed"
    t.index ["completed_at"], name: "index_quiz_games_on_completed_at"
    t.index ["score"], name: "index_quiz_games_on_score"
    t.index ["user_id"], name: "index_quiz_games_on_user_id"
  end

  create_table "quiz_questions", force: :cascade do |t|
    t.text "question_text", null: false
    t.string "option_a", null: false
    t.string "option_b", null: false
    t.string "option_c", null: false
    t.string "option_d", null: false
    t.string "correct_answer", null: false
    t.string "category"
    t.integer "difficulty", default: 1
    t.boolean "active", default: true
    t.datetime "active_from"
    t.datetime "active_until"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_quiz_questions_on_active"
    t.index ["active_from", "active_until"], name: "index_quiz_questions_on_active_from_and_active_until"
    t.index ["category"], name: "index_quiz_questions_on_category"
    t.index ["difficulty"], name: "index_quiz_questions_on_difficulty"
  end

  create_table "quiz_user_answers", force: :cascade do |t|
    t.bigint "quiz_game_id", null: false
    t.bigint "quiz_question_id", null: false
    t.string "selected_answer"
    t.boolean "is_correct"
    t.integer "time_taken"
    t.boolean "hint_used", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hint_used"], name: "index_quiz_user_answers_on_hint_used"
    t.index ["is_correct"], name: "index_quiz_user_answers_on_is_correct"
    t.index ["quiz_game_id", "quiz_question_id"], name: "index_quiz_user_answers_on_quiz_game_id_and_quiz_question_id", unique: true
    t.index ["quiz_game_id"], name: "index_quiz_user_answers_on_quiz_game_id"
    t.index ["quiz_question_id"], name: "index_quiz_user_answers_on_quiz_question_id"
  end

  create_table "racer_games", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_racer_games_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "external_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_rewarded_at"
  end

  create_table "wordle_games", force: :cascade do |t|
    t.integer "user_id"
    t.jsonb "game_state"
    t.datetime "active_until"
    t.integer "day_word_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "quiz_games", "users"
  add_foreign_key "quiz_user_answers", "quiz_games"
  add_foreign_key "quiz_user_answers", "quiz_questions"
  add_foreign_key "racer_games", "users"
end
