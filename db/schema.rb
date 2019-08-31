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

ActiveRecord::Schema.define(version: 2019_08_30_182335) do

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
    t.index ["person_id"], name: "index_love_languages_on_person_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.string "type"
    t.datetime "when"
    t.string "location"
    t.integer "friend_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notes", force: :cascade do |t|
    t.integer "person_id"
    t.integer "friend_id"
    t.integer "person_meeting_id"
    t.string "title"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.string "first_name"
    t.string "last_name"
    t.date "birthday"
    t.string "email"
    t.integer "phone_number"
    t.integer "love_language_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "people_meetings", force: :cascade do |t|
    t.integer "person_id"
    t.integer "meeting_id"
    t.string "feeling"
    t.string "description"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "befriender_id"
    t.integer "befriendee_id"
    t.string "reln_type"
    t.date "start"
  end

end
