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

ActiveRecord::Schema.define(version: 2019_09_08_155850) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "analytics", force: :cascade do |t|
    t.bigint "link_id", null: false
    t.bigint "user_id", null: false
    t.string "ip"
    t.string "device"
    t.string "device_type"
    t.string "os"
    t.string "browser"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["browser"], name: "index_analytics_on_browser"
    t.index ["device"], name: "index_analytics_on_device"
    t.index ["device_type"], name: "index_analytics_on_device_type"
    t.index ["ip"], name: "index_analytics_on_ip"
    t.index ["link_id"], name: "index_analytics_on_link_id"
    t.index ["os"], name: "index_analytics_on_os"
    t.index ["user_id"], name: "index_analytics_on_user_id"
  end

  create_table "links", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "title", null: false
    t.string "passcode"
    t.string "url", null: false
    t.integer "isEnabled", limit: 2, default: 1
    t.integer "isHighlight", limit: 2, default: 0
    t.integer "order", default: 0
    t.bigint "user_id", null: false
    t.datetime "expired_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_links_on_title"
    t.index ["url"], name: "index_links_on_url"
    t.index ["user_id"], name: "index_links_on_user_id"
    t.index ["uuid"], name: "index_links_on_uuid"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "username", null: false
    t.integer "status", limit: 2, default: 0
    t.datetime "expired_at", default: "2019-08-02 09:05:13"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "analytics", "links"
  add_foreign_key "analytics", "users"
  add_foreign_key "links", "users"
end
