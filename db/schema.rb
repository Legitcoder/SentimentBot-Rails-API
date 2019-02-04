# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_02_04_073714) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "feelings", force: :cascade do |t|
    t.string "mood"
    t.string "emoji"
    t.bigint "survey_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_feelings_on_survey_id"
  end

  create_table "responses", force: :cascade do |t|
    t.string "mood"
    t.string "emoji"
    t.bigint "survey_id"
    t.bigint "user_id"
    t.date "date"
    t.string "image_url"
    t.float "longitude"
    t.float "latitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "place", default: "N/A"
    t.index ["survey_id"], name: "index_responses_on_survey_id"
    t.index ["user_id"], name: "index_responses_on_user_id"
  end

  create_table "rpush_apps", force: :cascade do |t|
    t.string "name", null: false
    t.string "environment"
    t.text "certificate"
    t.string "password"
    t.integer "connections", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type", null: false
    t.string "auth_key"
    t.string "client_id"
    t.string "client_secret"
    t.string "access_token"
    t.datetime "access_token_expiration"
    t.text "apn_key"
    t.string "apn_key_id"
    t.string "team_id"
    t.string "bundle_id"
  end

  create_table "rpush_feedback", force: :cascade do |t|
    t.string "device_token"
    t.datetime "failed_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "app_id"
    t.index ["device_token"], name: "index_rpush_feedback_on_device_token"
  end

  create_table "rpush_notifications", force: :cascade do |t|
    t.integer "badge"
    t.string "device_token"
    t.string "sound"
    t.text "alert"
    t.text "data"
    t.integer "expiry", default: 86400
    t.boolean "delivered", default: false, null: false
    t.datetime "delivered_at"
    t.boolean "failed", default: false, null: false
    t.datetime "failed_at"
    t.integer "error_code"
    t.text "error_description"
    t.datetime "deliver_after"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "alert_is_json", default: false, null: false
    t.string "type", null: false
    t.string "collapse_key"
    t.boolean "delay_while_idle", default: false, null: false
    t.text "registration_ids"
    t.integer "app_id", null: false
    t.integer "retries", default: 0
    t.string "uri"
    t.datetime "fail_after"
    t.boolean "processing", default: false, null: false
    t.integer "priority"
    t.text "url_args"
    t.string "category"
    t.boolean "content_available", default: false, null: false
    t.text "notification"
    t.boolean "mutable_content", default: false, null: false
    t.string "external_device_id"
    t.string "thread_id"
    t.index ["delivered", "failed", "processing", "deliver_after", "created_at"], name: "index_rpush_notifications_multi", where: "((NOT delivered) AND (NOT failed))"
  end

  create_table "surveys", force: :cascade do |t|
    t.string "schedule"
    t.bigint "team_id"
    t.string "question"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "time"
    t.date "start_date"
    t.index ["team_id"], name: "index_surveys_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "team_name"
    t.integer "code"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "teams_users", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_teams_users_on_team_id"
    t.index ["user_id"], name: "index_teams_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.string "image_url", default: "https://res.cloudinary.com/dg3xzcms5/image/upload/v1548039381/images/default-profile-icon-24.jpg"
    t.boolean "is_admin", default: false
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone"
    t.boolean "subscribed", default: false
    t.boolean "is_team_member", default: false
    t.string "subscription"
    t.string "device_token", default: ""
    t.date "last_survey_date"
    t.index ["team_id"], name: "index_users_on_team_id"
  end

  add_foreign_key "feelings", "surveys"
  add_foreign_key "responses", "surveys"
  add_foreign_key "responses", "users"
  add_foreign_key "surveys", "teams"
  add_foreign_key "teams_users", "teams"
  add_foreign_key "teams_users", "users"
end
