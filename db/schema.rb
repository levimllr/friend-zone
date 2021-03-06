# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_09_06_232112) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "love_languages", force: :cascade do |t|
    t.integer "person_id"
    t.integer "gifts_rank"
    t.text "gifts_example"
    t.integer "time_rank"
    t.text "time_example"
    t.integer "affirmation_rank"
    t.text "affirmation_example"
    t.integer "service_rank"
    t.text "service_example"
    t.integer "touch_rank"
    t.text "touch_example"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "meetings", force: :cascade do |t|
    t.string "meeting_type"
    t.datetime "when"
    t.string "location"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "microposts", force: :cascade do |t|
    t.text "content"
    t.bigint "person_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "picture"
    t.index ["person_id", "created_at"], name: "index_microposts_on_person_id_and_created_at"
    t.index ["person_id"], name: "index_microposts_on_person_id"
  end

  create_table "notes", force: :cascade do |t|
    t.integer "person_id"
    t.integer "friend_id"
    t.integer "people_meeting_id"
    t.string "title"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.date "birthday"
    t.string "email"
    t.bigint "phone_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_people_on_email", unique: true
  end

  create_table "people_meetings", force: :cascade do |t|
    t.integer "person_id"
    t.integer "meeting_id"
    t.string "feeling"
    t.string "description"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "befriender_id"
    t.integer "befriended_id"
    t.string "reln_type"
    t.date "start"
    t.string "quality"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["befriended_id"], name: "index_relationships_on_befriended_id"
    t.index ["befriender_id", "befriended_id"], name: "index_relationships_on_befriender_id_and_befriended_id", unique: true
    t.index ["befriender_id"], name: "index_relationships_on_befriender_id"
  end

  add_foreign_key "microposts", "people"
end
