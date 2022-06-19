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

ActiveRecord::Schema[7.0].define(version: 2022_06_19_131236) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clock_ins", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "category"
    t.index ["user_id", "created_at"], name: "index_clock_ins_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_clock_ins_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.bigint "follower_id"
    t.bigint "followee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followee_id", "follower_id"], name: "index_relationships_on_followee_id_and_follower_id", unique: true
  end

  create_table "sleep_records", force: :cascade do |t|
    t.integer "duration"
    t.bigint "sleep_clock_in_id"
    t.bigint "wake_up_clock_in_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sleep_records_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "clock_ins", "users"
  add_foreign_key "sleep_records", "users"
end
